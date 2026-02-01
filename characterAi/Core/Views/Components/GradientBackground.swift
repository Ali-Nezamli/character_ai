//
//  GradientBackground.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 28/01/2026.
//

import SwiftUI

struct GradientBackground: View {
    var body: some View {
        LinearGradient(
            colors: [
                Color(red: 0.08, green: 0.02, blue: 0.20),  // Dark purple at top
                Color(red: 0.02, green: 0.02, blue: 0.08)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

#Preview {
    GradientBackground()
}
