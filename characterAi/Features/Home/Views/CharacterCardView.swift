//
//  Untitled.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 29/01/2026.
//

import SwiftUI

struct CharacterCardView: View {
    let character: CharacterItemModel
    
    var body: some View {
        VStack(spacing: 8) {
            CachedAsyncImage(
                url: character.avatar,
                isCircled: true
            )
            .frame(width: 80, height: 80)
            
            Text(character.name)
                .font(.system(size: 15))
                .foregroundStyle(.white)
                .lineLimit(1)
                .frame(width: 80)
        }
    }
}
