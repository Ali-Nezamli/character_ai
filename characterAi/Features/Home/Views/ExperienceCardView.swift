//
//  ExperienceCardView.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 29/01/2026.
//

import SwiftUI

struct ExperienceCardView: View {
    let character: CharacterItemModel
    var body: some View {
        VStack {
            ZStack (alignment: .topTrailing) {
                CachedAsyncImage(url: character.avatar)
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.bottom, 8)
                    
                HStack {
                    Image(systemName: "person.fill")
                     .foregroundStyle(.white)
                    Text("5502")
                        .font(.system(size: 12))
                        .foregroundStyle(.white)
                        
                }
                .background(.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.all)
            }
            
            HStack {
                Text(character.name)
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)
                Spacer()
                HStack {
                    Text(String(character.rating))
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                        
                       Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                }
                
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 15)
        
                
        }
        .background(.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.bottom, 10)
        
    }
       
}
