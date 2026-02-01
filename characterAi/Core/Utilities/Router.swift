//
//  Router.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 28/01/2026.
//
//  ============================================================
//  ROUTER - Centralized Navigation Management
//  ============================================================
//
//  SwiftUI Navigation works with NavigationStack (iOS 16+).
//  This Router manages navigation state centrally.
//
//  HOW SWIFTUI NAVIGATION WORKS:
//  ============================================================
//
//  1. NavigationStack - Container that enables navigation
//     NavigationStack {
//         HomeView()  // Root view
//     }
//
//  2. NavigationLink - Triggers navigation on tap
//     NavigationLink(value: Route.experienceDetail(character)) {
//         ExperienceCardView(character: character)  // Tappable view
//     }
//
//  3. .navigationDestination - Defines what view to show for each route
//     .navigationDestination(for: Route.self) { route in
//         switch route {
//         case .experienceDetail(let character):
//             ExperienceDetailView(character: character)
//         }
//     }
//
//  NAVIGATION APPROACHES:
//  ============================================================
//
//  APPROACH 1: Simple NavigationLink (Declarative)
//  -----------------------------------------------
//  Best for: Simple navigation, static routes
//
//     NavigationLink(value: Route.experienceDetail(character)) {
//         CardView()
//     }
//
//  APPROACH 2: Router with NavigationPath (Programmatic)
//  ------------------------------------------------------
//  Best for: Complex navigation, deep linking, conditional navigation
//
//     // In Router:
//     @Published var path = NavigationPath()
//     func navigate(to route: Route) { path.append(route) }
//
//     // In View:
//     NavigationStack(path: $router.path) { ... }
//     Button("Go") { router.navigate(to: .experienceDetail(character)) }
//
//  This app uses APPROACH 2 for flexibility.
//

import SwiftUI
import Combine

// MARK: - Route Enum
/// Defines all possible navigation destinations in the app
/// Each case represents a screen you can navigate to
///
/// WHY USE ENUM?
/// - Type-safe: Compiler catches typos
/// - Associated values: Pass data to destination (like character)
/// - Exhaustive: Switch statements must handle all cases
///
enum Route: Hashable {
    /// Home screen (root)
    case home

    /// Experience/Character detail screen
    /// Associated value: The character to display
    case experienceDetail(CharacterItemModel)

    /// Settings screen
    case settings

    // Add more routes as your app grows:
    // case chat(characterId: String)
    // case profile
    // case search
}

// MARK: - Router Class
/// Manages navigation state for the entire app
/// Uses @Published so SwiftUI views automatically update
///
/// WHY USE A ROUTER CLASS?
/// 1. Centralized: All navigation logic in one place
/// 2. Programmatic: Navigate from anywhere (ViewModels, services)
/// 3. Testable: Easy to mock for unit tests
/// 4. Deep linking: Can build navigation paths from URLs
///
final class Router: ObservableObject {

    // MARK: - Navigation State
    /// The navigation path/stack
    /// NavigationPath is a type-erased list of navigation destinations
    /// When you append to it, NavigationStack pushes a new view
    /// When you remove, it pops the view
    @Published var path = NavigationPath()

    // MARK: - Navigation Methods

    /// Navigate to a specific route (push onto stack)
    /// - Parameter route: The destination to navigate to
    ///
    /// Example:
    ///   router.navigate(to: .experienceDetail(character))
    ///
    func navigate(to route: Route) {
        path.append(route)
    }

    /// Go back one screen (pop from stack)
    /// Same as pressing back button
    func navigateBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }

    /// Go back to root/home screen (clear entire stack)
    /// Useful for "Go to Home" buttons
    func navigateToRoot() {
        path = NavigationPath()
    }

    /// Go back multiple screens
    /// - Parameter count: Number of screens to pop
    func navigateBack(count: Int) {
        let removeCount = min(count, path.count)
        path.removeLast(removeCount)
    }
}

// ============================================================
// COMPLETE NAVIGATION SETUP EXAMPLE
// ============================================================
//
// 1. IN APP FILE (Pass2PastiosApp.swift):
//    @StateObject private var router = Router()
//
//    WindowGroup {
//        NavigationStack(path: $router.path) {
//            HomeView()
//                .navigationDestination(for: Route.self) { route in
//                    // This switch determines which view to show
//                    switch route {
//                    case .home:
//                        HomeView()
//                    case .experienceDetail(let character):
//                        ExperienceDetailView(character: character)
//                    case .settings:
//                        SettingsView()
//                    }
//                }
//        }
//        .environmentObject(router)
//    }
//
// 2. IN ANY VIEW (to navigate):
//    @EnvironmentObject var router: Router
//
//    Button("View Details") {
//        router.navigate(to: .experienceDetail(character))
//    }
//
// 3. OR USE NavigationLink (simpler for basic cases):
//    NavigationLink(value: Route.experienceDetail(character)) {
//        ExperienceCardView(character: character)
//    }
//
