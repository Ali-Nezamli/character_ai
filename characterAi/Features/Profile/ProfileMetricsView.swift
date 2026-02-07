//
//  ProfileMetricsView.swift
//  characterAi
//
//  Created by Ali Nezamli on 07/02/2026.
//

import SwiftUI

struct ProfileMetricsView: View {
    var body: some View {
        HStack {
            ItemView(number: "124", title: "Posts")
            Spacer()
            Divider()
                .frame(height: 40)
            ItemView(number: "2.5K", title: "Followers")
                .padding()

            Divider()
                .frame(height: 40)
            Spacer()
            ItemView(number: "532", title: "Following")
        }
        .padding(.horizontal, 40)
    }
    struct ItemView: View {
        let number: String
        let title: String
        var body: some View {
            VStack {
                Text(number)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Text(title)
                    .font(.system(size: 15))
                    .foregroundStyle(.white)

            }
        }
    }
}
