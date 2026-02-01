//
//  ExperienceDetailsHeader.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 01/02/2026.
//

import SwiftUI

struct ExperienceDetailsHeader: View {
    let character: CharacterItemModel
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    @EnvironmentObject var router: Router
    var body: some View {
        ZStack(alignment: .topLeading) {
            CachedAsyncImage(url: character.avatar)
                .scaledToFill()
                .frame(maxWidth: screenWidth)
                .frame(height: screenHeight * 0.3)
                .cornerRadius(20)
                .clipped()
            Button {
                router.navigateBack()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.white)
                    .padding(.all)
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(20)
                    .padding(.top, 50)
                    .padding(.leading, 16)
            }
            
        }
    }
}
