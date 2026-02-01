//
//  HomeView.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 28/01/2026.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            HeaderView()
            ScrollView {
                CharactersListView(
                    characters: viewModel.characters,
                    isLoading: viewModel.isLoading
                )
                ExperienceListView(
                    characters: viewModel.characters,
                    isLoading: viewModel.isLoading
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.all)
        .background {
            GradientBackground()
        }
        .onAppear {
            viewModel.configure(with: modelContext)
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .environmentObject(Router())
    .modelContainer(for: Item.self, inMemory: true)
}
