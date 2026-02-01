//
//  HomeViewModel.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 28/01/2026.
//
//  ============================================================
//  HOME VIEW MODEL - UI State Management for Home Screen
//  ============================================================
//
//  The ViewModel is the "brain" of the View. It:
//  1. Holds all data the View needs to display
//  2. Handles user actions (button taps, etc.)
//  3. Calls services to fetch/save data
//  4. Manages loading/error states
//
//  IMPORTANT: ViewModel does NOT know about SwiftUI views!
//  It only exposes @Published properties that Views observe.
//
//  FLOW:
//  View (.onAppear) → ViewModel.configure() → Service.fetchData() → Update @Published → View refreshes
//

import Foundation
import SwiftData
import Combine

// MARK: - Home ViewModel
/// @MainActor ensures ALL code runs on main thread
/// This is required because:
/// 1. @Published properties must update on main thread
/// 2. SwiftUI observes changes on main thread
/// 3. SwiftData operations need main thread
@MainActor
final class HomeViewModel: BaseViewModel {

    // MARK: - Published Properties
    /// These properties trigger View updates when changed
    /// @Published uses Combine under the hood
    /// When `characters` changes, any View observing this ViewModel refreshes

    /// List of characters fetched from API
    /// View uses this to populate the horizontal list
    @Published var characters: [CharacterItemModel] = []

    // MARK: - Private Properties
    /// Service handles the actual data fetching
    /// Optional because it's set after init (needs ModelContext from View)
    private var service: HomeServiceProtocol?

    // MARK: - Configuration
    /// Called from View's .onAppear
    /// Sets up the service and starts loading data
    ///
    /// WHY CONFIGURE SEPARATELY?
    /// - ModelContext comes from SwiftUI environment
    /// - Can't access it in ViewModel's init
    /// - So we configure after View appears
    ///
    /// - Parameter modelContext: SwiftData context from @Environment
    func configure(with modelContext: ModelContext) {
        // Create service with dependencies
        self.service = HomeService(modelContext: modelContext)

        // Start fetching data
        // Task creates an async context for calling async functions
        Task {
            await fetchCharacters()
        }
    }

    // MARK: - Data Fetching
    /// Fetches characters from API and updates state
    ///
    /// FLOW:
    /// 1. Set loading state (shows loading UI)
    /// 2. Call service to fetch data
    /// 3. Update characters array (triggers View refresh)
    /// 4. Set success state (hides loading UI)
    /// OR
    /// 3. Catch error
    /// 4. Set error state (shows error UI)
    func fetchCharacters() async {
        // Guard: Make sure service exists
        guard let service = service else { return }

        // Show loading indicator
        // setLoading() is inherited from BaseViewModel
        setLoading(true)

        do {
            // ASYNC CALL: This pauses here until API responds
            // Service handles: Endpoint → NetworkService → URLSession → JSON decode
            characters = try await service.fetchCharacters()

            // Hide loading, show content
            setSuccess()
        } catch {
            // Show error message to user
            setError("Failed to fetch characters: \(error.localizedDescription)")
        }
    }
}

// ============================================================
// HOW VIEW CONNECTS TO VIEWMODEL
// ============================================================
//
// In HomeView.swift:
//
//   struct HomeView: View {
//       // Get ModelContext from SwiftUI environment
//       @Environment(\.modelContext) private var modelContext
//
//       // Create and observe ViewModel
//       // @StateObject keeps it alive across view updates
//       @StateObject private var viewModel = HomeViewModel()
//
//       var body: some View {
//           VStack {
//               // Use ViewModel's data
//               ForEach(viewModel.characters) { character in
//                   Text(character.name)
//               }
//
//               // Use ViewModel's state
//               if viewModel.isLoading {
//                   ProgressView()
//               }
//           }
//           .onAppear {
//               // Initialize ViewModel when View appears
//               viewModel.configure(with: modelContext)
//           }
//       }
//   }
//
// ============================================================
// COMPLETE DATA FLOW
// ============================================================
//
// 1. USER: Opens app
//
// 2. VIEW: HomeView appears
//    .onAppear { viewModel.configure(with: modelContext) }
//
// 3. VIEWMODEL: configure() called
//    - Creates HomeService
//    - Calls fetchCharacters()
//
// 4. VIEWMODEL: fetchCharacters()
//    - setLoading(true) → View shows loading indicator
//    - Calls service.fetchCharacters()
//
// 5. SERVICE: fetchCharacters()
//    - Calls networkService.request(CharactersEndpoint.getCharacters)
//
// 6. NETWORK SERVICE: request()
//    - Builds URL from endpoint
//    - Creates URLRequest
//    - Calls URLSession.data(for: request)
//
// 7. SERVER: Responds with JSON
//    { "data": [{ "id": "1", "name": "Bot", "avatar": "..." }, ...] }
//
// 8. NETWORK SERVICE: Decodes JSON
//    - decoder.decode(CharacterResponse.self, from: data)
//    - Returns CharacterResponse object
//
// 9. SERVICE: Returns data
//    - return response.data (the array)
//
// 10. VIEWMODEL: Updates state
//     - characters = [CharacterItemModel, ...]
//     - setSuccess() → View hides loading
//
// 11. VIEW: Refreshes automatically
//     - @Published characters changed
//     - SwiftUI re-renders ForEach
//     - User sees character list!
//
