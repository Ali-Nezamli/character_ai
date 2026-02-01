//
//  Router+Extensions.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 31/01/2026.
//

import SwiftUI

extension Route {
    /// Returns the destination view for this route
    @ViewBuilder
    func destination() -> some View {
        switch self {
        case .home:
            // Usually you don't navigate TO home, you pop back
            HomeView()
            
        case .experienceDetail(let character):
            // Pass the character data to the detail view
            ExperienceDetailView(character: character)
            
        case .settings:
            // TODO: Create SettingsView
            Text("Settings Coming Soon")
        }
    }
}
