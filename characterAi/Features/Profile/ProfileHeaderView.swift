//
//  ProfileHeader.swift
//  characterAi
//
//  Created by Ali Nezamli on 07/02/2026.
//

import SwiftUI

struct ProfileHeaderView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundStyle(.white)
                .applyShape(isCircled: true, cornerRadius: 10)
            Text("Sarah Anderson")
                .font(.system(size: 20))
                .foregroundStyle(.white)
                .fontWeight(.bold)
            Text(AttributedString("sarah@gmail.com"))
                .font(.system(size: 15))
                .foregroundStyle(.gray)
        }
        .padding()
        HStack {
            PrimaryButton(
                title: "Edit Profile",
                action: {
                    print("edit pressed")
                },
                width: 160
            )
            IconButton(
                icon: "square.and.arrow.up.fill",
                action: {

                },
                color: .white,
                borderColor: .gray,

            )
        }
        .padding(.bottom, 20)
    }
}
