//
//  NetworkService.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 28/01/2026.
//
//  ============================================================
//  NETWORK SERVICE - The core networking layer
//  ============================================================
//
//  This is the SINGLE place where ALL API calls happen.
//  Instead of writing URLSession code everywhere, we centralize it here.
//
//  HOW IT WORKS:
//  1. You pass an Endpoint (which contains URL, method, headers, etc.)
//  2. NetworkService builds the URLRequest
//  3. Makes the API call using URLSession
//  4. Decodes the JSON response to your model
//  5. Returns the decoded object or throws an error
//
//  USAGE EXAMPLE:
//  let characters: [Character] = try await NetworkService.shared.request(CharactersEndpoint.getCharacters)
//

import Foundation

// MARK: - Network Errors
/// Custom error types for network operations
/// These provide clear, user-friendly error messages
enum NetworkError: LocalizedError {
    case invalidURL          // URL couldn't be created
    case noData              // Server returned empty response
    case decodingError       // JSON couldn't be parsed to your model
    case serverError(Int)    // Server returned error (400, 401, 500, etc.)
    case unknown(Error)      // Unexpected error

    /// Human-readable error messages
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Failed to decode response"
        case .serverError(let code):
            return "Server error: \(code)"
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}

// MARK: - Protocol
/// Protocol allows us to mock NetworkService for unit testing
/// Instead of making real API calls in tests, we can create a fake NetworkService
protocol NetworkServiceProtocol {
    /// Generic function that can return ANY Decodable type
    /// T is determined by what you assign the result to
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

// MARK: - Network Service Implementation
/// The actual implementation of our networking layer
final class NetworkService: NetworkServiceProtocol {

    // MARK: - Singleton
    /// Shared instance - use this throughout the app
    /// Example: NetworkService.shared.request(...)
    static let shared = NetworkService()

    // MARK: - Properties
    private let session: URLSession   // Apple's networking class
    private let decoder: JSONDecoder  // Converts JSON to Swift objects

    // MARK: - Initialization
    /// Sets up the service with default configurations
    /// - Parameter session: URLSession instance (defaults to .shared)
    init(session: URLSession = .shared) {
        self.session = session
        self.decoder = JSONDecoder()

        // IMPORTANT: This converts snake_case JSON keys to camelCase Swift properties
        // API returns: { "first_name": "Ali" }
        // Swift model: var firstName: String  ← automatically mapped!
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase

        // Automatically parse ISO8601 date strings to Date objects
        self.decoder.dateDecodingStrategy = .iso8601
    }

    // MARK: - Main Request Function
    /// Makes an API request and returns decoded response
    ///
    /// - Parameter endpoint: Contains URL, method, headers, body info
    /// - Returns: Decoded object of type T (determined by caller)
    /// - Throws: NetworkError if something goes wrong
    ///
    /// HOW GENERIC <T: Decodable> WORKS:
    /// The return type is determined by what you assign it to:
    ///
    /// let users: [User] = try await request(endpoint)  // T becomes [User]
    /// let response: CharacterResponse = try await request(endpoint)  // T becomes CharacterResponse
    ///
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {

        // STEP 1: Get URL from endpoint
        // endpoint.url combines baseURL + path + queryItems
        // Example: "http://164.92.192.249:37575/" + "characters" = "http://164.92.192.249:37575/characters"
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }

        // STEP 2: Create URLRequest
        // URLRequest is what URLSession actually sends to the server
        var request = URLRequest(url: url)

        // Set HTTP method (GET, POST, PUT, DELETE, etc.)
        request.httpMethod = endpoint.method.rawValue  // .GET.rawValue = "GET"

        // Set headers (Content-Type, Authorization, etc.)
        request.allHTTPHeaderFields = endpoint.headers

        // STEP 3: Add body for POST/PUT requests
        // Only needed when sending data TO the server
        if let body = endpoint.body {
            // Convert dictionary to JSON data
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        // STEP 4: Make the actual network call
        // This is where the request goes to the server
        // async/await pauses here until server responds
        let (data, response) = try await session.data(for: request)
        // data = JSON bytes from server
        // response = metadata (status code, headers, etc.)

        // STEP 5: Validate response
        // Cast to HTTPURLResponse to access statusCode
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown(NSError(domain: "Invalid response", code: -1))
        }

        // Check if status code is successful (200-299)
        // 200 = OK, 201 = Created, 204 = No Content, etc.
        guard (200...299).contains(httpResponse.statusCode) else {
            // 400 = Bad Request, 401 = Unauthorized, 404 = Not Found, 500 = Server Error
            throw NetworkError.serverError(httpResponse.statusCode)
        }

        // STEP 6: Decode JSON to Swift object
        // decoder.decode(T.self, from: data)
        // T.self tells decoder what type to decode to
        // Example: If T is CharacterResponse, it decodes JSON to CharacterResponse
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            // JSON structure doesn't match your model
            // Check your model properties match the JSON keys
            print("Decoding error: \(error)")  // Helpful for debugging
            throw NetworkError.decodingError
        }
    }
}
