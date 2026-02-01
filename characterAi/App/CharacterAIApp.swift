//
//  Pass2PastiosApp.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 28/01/2026.
//
//  ============================================================
//  APP ENTRY POINT - Main application setup
//  ============================================================
//
//  This is where the app starts. Key responsibilities:
//  1. Create the Router (navigation manager)
//  2. Create the SwiftData container (database)
//  3. Set up NavigationStack (enables navigation)
//  4. Define navigation destinations (which view for each route)
//

import SwiftUI
import SwiftData
import Combine

@main
struct CharacterAIApp: App {

    // MARK: - State Objects
    /// Router manages all navigation in the app
    /// @StateObject keeps it alive for the app's lifetime
    @StateObject private var router = Router()
   

    // MARK: - SwiftData Container
    /// Database container for local persistence
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    // MARK: - App Body
    var body: some Scene {
        WindowGroup {
            // ============================================================
            // NAVIGATION STACK SETUP
            // ============================================================
            //
            // NavigationStack is the container that enables navigation.
            // It takes a binding to router.path, which tracks the nav stack.
            //
            // When router.path changes:
            // - Items added → new view is pushed
            // - Items removed → view is popped
            //
            NavigationStack(path: $router.path) {
                // Root view - this is shown when path is empty
                HomeView()
                    // ============================================================
                    // NAVIGATION DESTINATIONS
                    // ============================================================
                    //
                    // .navigationDestination tells SwiftUI which view to show
                    // for each Route value.
                    //
                    // When NavigationLink(value: Route.xxx) is tapped,
                    // or router.navigate(to: .xxx) is called,
                    // SwiftUI looks here to find the matching view.
                    //
                    .navigationDestination(for: Route.self) { route in
                        route.destination()
                    }
            }
            // Pass router to all child views via environment
            .environmentObject(router)
        }
        .modelContainer(sharedModelContainer)
    }
}

// ============================================================
// NAVIGATION FLOW DIAGRAM
// ============================================================
//
//  ┌─────────────────────────────────────────────────────────┐
//  │                    Pass2PastiosApp                       │
//  │  ┌────────────────────────────────────────────────────┐ │
//  │  │            NavigationStack(path: $router.path)      │ │
//  │  │  ┌──────────────────────────────────────────────┐  │ │
//  │  │  │                 HomeView                      │  │ │
//  │  │  │                                               │  │ │
//  │  │  │  ┌─────────────────────────────────────────┐  │  │ │
//  │  │  │  │         ExperienceCardView              │  │  │ │
//  │  │  │  │  NavigationLink(value: .experienceDetail)│  │  │ │
//  │  │  │  │                  │                       │  │  │ │
//  │  │  │  │                  ▼ (on tap)              │  │  │ │
//  │  │  │  └──────────────────┬──────────────────────┘  │  │ │
//  │  │  └────────────────────┬┼─────────────────────────┘  │ │
//  │  │                       ││                             │ │
//  │  │  .navigationDestination(for: Route.self)            │ │
//  │  │                       ││                             │ │
//  │  │                       ▼▼                             │ │
//  │  │  ┌──────────────────────────────────────────────┐  │ │
//  │  │  │           ExperienceDetailView               │  │ │
//  │  │  │           (pushed onto stack)                │  │ │
//  │  │  └──────────────────────────────────────────────┘  │ │
//  │  └────────────────────────────────────────────────────┘ │
//  └─────────────────────────────────────────────────────────┘
//
