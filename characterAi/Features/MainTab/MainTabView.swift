//
//  MainTabView.swift
//  characterAi
//
//  Created by Ali Nezamli on 01/02/2026.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)          
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(1)
//            
//            FavoritesView()
//                .tabItem {
//                    Image(systemName: "heart.fill")
//                    Text("Favorites")
//                }
//                .tag(2)
//            
//            ProfileView()
//                .tabItem {
//                    Image(systemName: "person.fill")
//                    Text("Profile")
//                }
//                .tag(3)
        }
        .accentColor(.blue) // Selected tab color
    }
}
#Preview {
    NavigationStack {
        MainTabView()
    }
    .environmentObject(Router())
}
