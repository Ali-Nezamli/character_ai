//
//  CharactersListView.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 29/01/2026.
//

import SwiftUI

struct CharactersListView: View {
    let characters: [CharacterItemModel]
    let isLoading: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Experiences")
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal)
            
            contentView
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        if isLoading && characters.isEmpty {
            HorizontalCharactersListLoading()
        } else if characters.isEmpty {
            emptyStateView
        } else {
            charactersScrollView
        }
    }
    
    private var emptyStateView: some View {
        Text("No characters available")
            .foregroundStyle(.white.opacity(0.6))
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
    }
    
    private var charactersScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(characters) { character in
                    CharacterCardView(character: character)
                        .onTapGesture {
                            // Handle tap
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct HorizontalCharactersListLoading: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(0..<5, id: \.self) { _ in
                    VStack {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 80, height: 80)
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 60, height: 12)
                    }
                    .frame(width: 100)
                }
            }
            .padding(.horizontal)
        }
    }
}
