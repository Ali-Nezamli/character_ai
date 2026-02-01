//
//  ExperienceDetailView.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 31/01/2026.
//
//  ============================================================
//  EXPERIENCE DETAIL VIEW - Shows full character details
//  ============================================================
//
//  This view is displayed when user taps on an ExperienceCard.
//  It receives the character data from the navigation.
//

import SwiftUI

struct ExperienceDetailView: View {
    let character: CharacterItemModel
    // Access router from environment for programmatic navigation
    @EnvironmentObject var router: Router
    
    var body: some View {
        GeometryReader { geometry in
            let screenHeight = geometry.size.height
            let screenWidth = geometry.size.width
            ScrollView {
                    ExperienceDetailsHeader(
                        character: character,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight)
                VStack(alignment: .leading) {
                    Text(character.name)
                        .foregroundStyle(.white)
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .frame(maxWidth: screenWidth, alignment: .leading)
                        .padding(.bottom, 5)
                    StarRatingView(rating: character.rating, size: 25)
                    Text("Experience Details")
                        .foregroundStyle(.white)
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .padding(.top, 20)
                        .padding(.bottom, 8)
                    Text(character.description ?? "")
                        .foregroundStyle(.white)
                        .font(.system(size: 14))
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundStyle(.white)
                                Text(String(character.chatsCount))
                                    .foregroundStyle(.white)
                                    .font(.system(size: 15))
                            }
                            .padding(.bottom, 5)
                            Text("Daily Users")
                                .foregroundStyle(.white)
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            HStack {
                                Image(AppIcons.gemsIcon)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text(String(character.cost))
                                    .foregroundStyle(.white)
                                    .font(.system(size: 15))
                            }
                            .padding(.bottom, 5)
                            Text("Coins Per Message")
                                .foregroundStyle(.white)
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                        }
                       
                    }
                    .padding(.top, 10)
                }//VStack
                .padding(.all)
            }//Scroll View
            .scrollBounceBehavior(.basedOnSize)
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden(true)
        .background {
            GradientBackground()
        }
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(title: "Start Experience") {
                
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        ExperienceDetailView(
            character: CharacterItemModel(
                id: "char_001",
                variationId: "var_a1",
                createdAt: "2024-01-15T10:30:00Z",
                avatar: "https://picsum.photos/seed/char1/400",
                name: "Historical Einstein",
                dontShow: false,
                firstMessage: "Greetings! I am Albert Einstein. Let us explore the mysteries of the universe together. What questions do you have about physics, mathematics, or the nature of reality?",
                cost: 15,
                costs: [
                    Cost(cost: 10, from: 0),
                    Cost(cost: 15, from: 100),
                    Cost(cost: 20, from: 500)
                ],
                state: "active",
                acceptPhotos: true,
                shouldReturnAds: false,
                description: "Experience conversations with the legendary physicist Albert Einstein. Discuss theories of relativity, quantum mechanics, and the philosophical implications of scientific discovery.",
                voiceId: "voice_einstein_01",
                chatsCount: 12547,
                rating: 4.8
            )
        )
    }
    .environmentObject(Router())
}
