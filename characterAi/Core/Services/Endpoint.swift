//
//  Endpoint.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 28/01/2026.
//
//  ============================================================
//  ENDPOINT PROTOCOL - Blueprint for all API endpoints
//  ============================================================
//
//  Think of this as a "contract" that all endpoints must follow.
//  Every endpoint (Characters, Users, Auth, etc.) must provide:
//  - baseURL: The server address
//  - path: The specific route (e.g., "/characters", "/users")
//  - method: GET, POST, PUT, DELETE
//  - headers: Authorization tokens, content type, etc.
//  - queryItems: URL parameters (e.g., ?page=1&limit=10)
//  - body: Data to send (for POST/PUT requests)
//
//  WHY USE THIS PATTERN?
//  1. Type-safe: Compiler catches mistakes
//  2. Organized: All endpoint info in one place
//  3. Reusable: Same NetworkService works with any endpoint
//  4. Testable: Easy to mock for unit tests
//

import Foundation

// MARK: - HTTP Methods
/// Standard HTTP methods for REST APIs
/// These map directly to URLRequest.httpMethod
enum HTTPMethod: String {
    case GET     // Fetch data (read-only)
    case POST    // Create new data
    case PUT     // Update/replace existing data
    case PATCH   // Partial update
    case DELETE  // Remove data
}

// MARK: - Endpoint Protocol
/// The blueprint that ALL endpoints must follow
/// Each endpoint enum (CharactersEndpoint, AuthEndpoint, etc.) conforms to this
protocol Endpoint {
    var baseURL: String { get }              // Server address
    var path: String { get }                 // Route after base URL
    var method: HTTPMethod { get }           // HTTP method
    var headers: [String: String]? { get }   // Request headers
    var queryItems: [URLQueryItem]? { get }  // URL query parameters
    var body: [String: Any]? { get }         // Request body (for POST/PUT)
}

// MARK: - Default Implementations
/// Default values so you don't have to implement everything in each endpoint
/// Override these in your specific endpoint if needed
extension Endpoint {

    /// Default base URL from AppConstants
    /// All endpoints use this unless overridden
    /// Example: "http://164.92.192.249:37575/"
    var baseURL: String {
        return AppConstants.API.baseURL
    }

    /// Default headers for JSON API
    /// Add Authorization header here for authenticated endpoints
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
        // For authenticated endpoints, override this:
        // return [
        //     "Content-Type": "application/json",
        //     "Authorization": "Bearer \(token)"
        // ]
    }

    /// Default: no query parameters
    /// Override for endpoints that need URL params
    var queryItems: [URLQueryItem]? {
        return nil
        // Example override for pagination:
        // return [
        //     URLQueryItem(name: "page", value: "1"),
        //     URLQueryItem(name: "limit", value: "20")
        // ]
    }

    /// Default: no body
    /// Override for POST/PUT requests that send data
    var body: [String: Any]? {
        return nil
        // Example override for login:
        // return [
        //     "email": "user@example.com",
        //     "password": "secret123"
        // ]
    }

    /// Constructs the full URL from baseURL + path + queryItems
    ///
    /// Example:
    /// baseURL = "http://164.92.192.249:37575/"
    /// path = "characters"
    /// queryItems = [page: 1, limit: 10]
    ///
    /// Result: "http://164.92.192.249:37575/characters?page=1&limit=10"
    var url: URL? {
        // Combine base URL and path
        let urlString = baseURL + path

        // URLComponents helps us build URLs safely
        var components = URLComponents(string: urlString)

        // Add query parameters if any
        if let queryItems = queryItems, !queryItems.isEmpty {
            components?.queryItems = queryItems
        }

        // Return the final URL
        return components?.url
    }
}

// ============================================================
// HOW TO CREATE A NEW ENDPOINT:
// ============================================================
//
// 1. Create new file: Features/YourFeature/Services/YourEndpoint.swift
//
// 2. Define the endpoint enum:
//
//    enum UserEndpoint: Endpoint {
//        case getUsers
//        case getUser(id: String)
//        case createUser(name: String, email: String)
//        case deleteUser(id: String)
//
//        var path: String {
//            switch self {
//            case .getUsers:
//                return "users"
//            case .getUser(let id):
//                return "users/\(id)"
//            case .createUser:
//                return "users"
//            case .deleteUser(let id):
//                return "users/\(id)"
//            }
//        }
//
//        var method: HTTPMethod {
//            switch self {
//            case .getUsers, .getUser:
//                return .GET
//            case .createUser:
//                return .POST
//            case .deleteUser:
//                return .DELETE
//            }
//        }
//
//        var body: [String: Any]? {
//            switch self {
//            case .createUser(let name, let email):
//                return ["name": name, "email": email]
//            default:
//                return nil
//            }
//        }
//    }
//
// 3. Use it in your service:
//
//    let users: [User] = try await networkService.request(UserEndpoint.getUsers)
//    let user: User = try await networkService.request(UserEndpoint.getUser(id: "123"))
//
