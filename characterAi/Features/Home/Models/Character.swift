//
//  Character.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 28/01/2026.
//

import Foundation

// MARK: - API Response Wrapper
struct CharacterResponse: Codable {
    let data: [CharacterItemModel]
}

// MARK: - Character Model
/// Hashable conformance is needed for NavigationLink(value:) to work
/// Route enum uses CharacterItemModel as associated value
struct CharacterItemModel: Identifiable, Codable, Hashable {
    let id: String
    let variationId: String
    let createdAt: String
    let avatar: String
    let name: String
    let dontShow: Bool
    let firstMessage: String
    let cost: Int
    let costs: [Cost]?
    let state: String
    let acceptPhotos: Bool
    let shouldReturnAds: Bool
    let description: String?
    let voiceId: String?
    let chatsCount: Int
    let rating: Double
}

// MARK: - Cost Model
struct Cost: Codable, Hashable {
    let cost: Int
    let from: Int
}
