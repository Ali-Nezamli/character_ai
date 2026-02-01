//
//  CharactersEndpoint.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 28/01/2026.
//
//  ============================================================
//  CHARACTERS ENDPOINT - Defines all character-related API routes
//  ============================================================
//
//  This enum conforms to the Endpoint protocol.
//  Each case represents a different API call.
//
//  CURRENT ENDPOINTS:
//  - getCharacters: GET http://164.92.192.249:37575/characters
//
//  TO ADD MORE ENDPOINTS:
//  - Add new case: case getCharacter(id: String)
//  - Add path: return "characters/\(id)"
//  - Add method: return .GET
//

import Foundation

/// All character-related API endpoints
/// Conforms to Endpoint protocol (see Endpoint.swift)
enum CharactersEndpoint: Endpoint {

    // MARK: - Available Endpoints
    /// Fetches list of all characters
    /// URL: GET /characters
    case getCharacters

    // Add more endpoints here as needed:
    // case getCharacter(id: String)      // GET /characters/{id}
    // case createCharacter(name: String) // POST /characters
    // case deleteCharacter(id: String)   // DELETE /characters/{id}

    // MARK: - Path
    /// The URL path for each endpoint
    /// This gets appended to baseURL
    ///
    /// Example:
    /// baseURL: "http://164.92.192.249:37575/"
    /// path: "characters"
    /// Result: "http://164.92.192.249:37575/characters"
    var path: String {
        switch self {
        case .getCharacters:
            return "characters"

        // Examples for other endpoints:
        // case .getCharacter(let id):
        //     return "characters/\(id)"  // → /characters/123
        // case .createCharacter:
        //     return "characters"
        // case .deleteCharacter(let id):
        //     return "characters/\(id)"
        }
    }

    // MARK: - HTTP Method
    /// The HTTP method for each endpoint
    /// GET = fetch data, POST = create, PUT = update, DELETE = remove
    var method: HTTPMethod {
        switch self {
        case .getCharacters:
            return .GET

        // Examples for other endpoints:
        // case .getCharacter:
        //     return .GET
        // case .createCharacter:
        //     return .POST
        // case .deleteCharacter:
        //     return .DELETE
        }
    }

    // MARK: - Request Body (Optional)
    /// Data to send with POST/PUT requests
    /// Returns nil for GET requests (no body needed)
    ///
    /// Example for POST:
    /// var body: [String: Any]? {
    ///     switch self {
    ///     case .createCharacter(let name):
    ///         return ["name": name]
    ///     default:
    ///         return nil
    ///     }
    /// }

    // MARK: - Query Parameters (Optional)
    /// URL query parameters (e.g., ?page=1&limit=10)
    ///
    /// Example for pagination:
    /// var queryItems: [URLQueryItem]? {
    ///     switch self {
    ///     case .getCharacters:
    ///         return [
    ///             URLQueryItem(name: "page", value: "1"),
    ///             URLQueryItem(name: "limit", value: "20")
    ///         ]
    ///     default:
    ///         return nil
    ///     }
    /// }
}

// ============================================================
// HOW THIS ENDPOINT IS USED:
// ============================================================
//
// In HomeService.swift:
//
//   func fetchCharacters() async throws -> [CharacterItemModel] {
//       // 1. Pass the endpoint to NetworkService
//       let response: CharacterResponse = try await networkService.request(
//           CharactersEndpoint.getCharacters  // ← This endpoint
//       )
//       // 2. Return the data array from response
//       return response.data
//   }
//
// What happens internally:
//
// 1. CharactersEndpoint.getCharacters provides:
//    - path: "characters"
//    - method: .GET
//    - headers: ["Content-Type": "application/json"] (default)
//    - body: nil (default, not needed for GET)
//
// 2. Endpoint protocol extension builds URL:
//    - baseURL + path = "http://164.92.192.249:37575/characters"
//
// 3. NetworkService:
//    - Creates URLRequest with URL and method
//    - Makes the network call
//    - Decodes JSON to CharacterResponse
//    - Returns the decoded object
//
