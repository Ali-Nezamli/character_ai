//
//  SettingsVIew.swift
//  characterAi
//
//  Created by Ali Nezamli on 07/02/2026.
//
import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Settings")
                .font(.system(size: 25))
                .fontWeight(.bold)
                .foregroundStyle(.white)
            SettingsRow(
                icon: "person.fill",
                iconColor: .gray,
                title: "Account Settings"
            ) {

            }
            SettingsRow(
                icon: "lock.fill",
                iconColor: .gray,
                title: "Privacy & Security"
            ) {

            }

            SettingsRow(
                icon: "bell.fill",
                iconColor: .gray,
                title: "Notifications"
            ) {

            }

            SettingsRow(
                icon: "questionmark.circle.fill",
                iconColor: .gray,
                title: "Help & Support"
            ) {

            }

        }
        .padding(.top, 20)
        }
}

struct SettingsRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                // Icon with circular background
                ZStack {
                    Circle()
                        .fill(iconColor.opacity(0.2))
                        .frame(width: 40, height: 40)

                    Image(systemName: icon)
                        .font(.system(size: 16))
                        .foregroundColor(iconColor)
                }

                // Title
                Text(title)
                    .font(.system(size: 16))
                    .foregroundColor(.white)

                Spacer()

                // Chevron
                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
            }
            .padding(.vertical, 16)
        }
        .buttonStyle(.plain)
    }
}
