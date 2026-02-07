//
//  profileView.swift
//  characterAi
//
//  Created by Ali Nezamli on 07/02/2026.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var router: Router
    var body: some View {
        ScrollView {
            VStack {
                ProfileHeaderView()
                Divider()
                    .frame(height: 0.5)
                    .background(Color.white)
                ProfileMetricsView()
                Divider()
                    .frame(height: 0.5)
                    .background(Color.white)
                SettingsView()
            }
        }
        .padding()
        .background {
            GradientBackground()
        }
        .scrollIndicators(ScrollIndicatorVisibility.hidden)
    }

}

#Preview {
    NavigationStack {
        ProfileView()
    }
    .environmentObject(Router())
}
