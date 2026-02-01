//
//  ExperienceListView.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 29/01/2026.
//
//  ============================================================
//  EXPERIENCE LIST VIEW - Vertical list of experience cards
//  ============================================================
//
//  This view displays a list of character/experience cards.
//  Each card is wrapped in NavigationLink to enable navigation.
//
//  NAVIGATION PATTERN USED:
//  NavigationLink(value: Route.experienceDetail(character)) { CardView() }
//
//  When tapped:
//  1. NavigationLink appends Route.experienceDetail(character) to navigation path
//  2. NavigationStack sees the new route
//  3. .navigationDestination matches Route and shows ExperienceDetailView
//

import SwiftUI

struct ExperienceListView: View {
    let characters: [CharacterItemModel]
    let isLoading: Bool

    // Access router from environment for programmatic navigation
    @EnvironmentObject var router: Router

    var body: some View {
        VStack(alignment: .leading) {
            Text("Daily Picks")
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal)

            contentView
        }
        .padding(.top, 10)
    }

    @ViewBuilder
    private var contentView: some View {
        if isLoading && characters.isEmpty {
            ExperiencesListLoading()
        } else if characters.isEmpty {
            emptyStateView
        } else {
            experiencesScrollView
        }
    }

    private var emptyStateView: some View {
        Text("No experiences available")
            .foregroundStyle(.white.opacity(0.6))
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
    }

    private var experiencesScrollView: some View {
        LazyVStack(spacing: 16) {
            ForEach(characters) { character in
                // ============================================================
                // PROGRAMMATIC NAVIGATION
                // ============================================================
                //
                // Using onTapGesture + Router instead of NavigationLink
                // This avoids NavigationLink's styling issues (gray tint)
                //
                // When tapped:
                // 1. router.navigate(to:) appends route to path
                // 2. NavigationStack sees the new route
                // 3. .navigationDestination matches and shows ExperienceDetailView
                //
                ExperienceCardView(character: character)
                    .onTapGesture {
                        router.navigate(to: .experienceDetail(character))
                    }
            }
        }
    }
}

struct ExperiencesListLoading: View {
    var body: some View {
        LoadingView()
    }
}

// ============================================================
// ALTERNATIVE: Programmatic Navigation with Router
// ============================================================
//
// If you need more control (e.g., conditional navigation),
// you can use the Router directly:
//
// struct ExperienceListView: View {
//     @EnvironmentObject var router: Router
//
//     var body: some View {
//         ForEach(characters) { character in
//             ExperienceCardView(character: character)
//                 .onTapGesture {
//                     // Programmatic navigation
//                     router.navigate(to: .experienceDetail(character))
//                 }
//         }
//     }
// }
//
// Use this approach when:
// - You need to do something before navigating (validation, API call)
// - Navigation is conditional
// - You're navigating from a ViewModel
//
