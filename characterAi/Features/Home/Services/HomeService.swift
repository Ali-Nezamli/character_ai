//
//  HomeService.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 28/01/2026.
//
//  ============================================================
//  HOME SERVICE - Business logic layer for Home feature
//  ============================================================
//
//  This service acts as a bridge between ViewModel and NetworkService.
//  It handles data fetching and any business logic transformations.
//
//  WHY USE A SERVICE LAYER?
//  1. Separation of concerns: ViewModel doesn't know about networking
//  2. Testable: Can mock this service for unit tests
//  3. Reusable: Multiple ViewModels can use the same service
//  4. Clean: ViewModel stays focused on UI state management
//
//  FLOW:
//  HomeView → HomeViewModel → HomeService → NetworkService → API
//

import Foundation
import SwiftData

// MARK: - Protocol
/// Protocol for dependency injection and testing
/// Allows us to create a mock service for unit tests
protocol HomeServiceProtocol {
    /// Fetches characters from the API
    func fetchCharacters() async throws -> [CharacterItemModel]
}

// MARK: - Implementation
/// The actual service implementation
/// @MainActor ensures all operations run on main thread (required for SwiftData)
@MainActor
final class HomeService: HomeServiceProtocol {

    // MARK: - Dependencies
    /// SwiftData context for local database operations
    private let modelContext: ModelContext

    /// Network service for API calls
    /// Uses protocol type for easy mocking in tests
    private let networkService: NetworkServiceProtocol

    // MARK: - Initialization
    /// Creates service with required dependencies
    /// - Parameters:
    ///   - modelContext: SwiftData context (passed from View)
    ///   - networkService: Network service (defaults to shared singleton)
    init(modelContext: ModelContext, networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.modelContext = modelContext
        self.networkService = networkService
    }

    // MARK: - API Methods
    /// Fetches characters from the remote API
    ///
    /// STEP BY STEP:
    /// 1. Call networkService.request() with CharactersEndpoint
    /// 2. NetworkService builds URL from endpoint
    /// 3. NetworkService makes HTTP request
    /// 4. NetworkService decodes JSON to CharacterResponse
    /// 5. We extract and return the data array
    ///
    /// - Returns: Array of CharacterItemModel
    /// - Throws: NetworkError if request fails
    func fetchCharacters() async throws -> [CharacterItemModel] {
        // Make API call using NetworkService
        // The generic type CharacterResponse tells decoder what to expect
        let response: CharacterResponse = try await networkService.request(
            CharactersEndpoint.getCharacters  // Provides URL, method, headers
        )

        // API returns: { "data": [...characters...] }
        // We extract just the array
        return response.data
    }

}

// ============================================================
// ADDING A NEW API CALL - EXAMPLE
// ============================================================
//
// 1. Add method to protocol:
//    protocol HomeServiceProtocol {
//        func fetchCharacters() async throws -> [CharacterItemModel]
//        func getCharacterDetail(id: String) async throws -> CharacterItemModel  // NEW
//    }
//
// 2. Add endpoint case (in CharactersEndpoint.swift):
//    case getCharacter(id: String)
//
// 3. Implement in service:
//    func getCharacterDetail(id: String) async throws -> CharacterItemModel {
//        let response: CharacterItemModel = try await networkService.request(
//            CharactersEndpoint.getCharacter(id: id)
//        )
//        return response
//    }
//
// 4. Call from ViewModel:
//    let character = try await service.getCharacterDetail(id: "123")
//
