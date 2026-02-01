//
//  StartRating.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 01/02/2026.
//
import SwiftUI

struct StarRatingView: View {
    let rating: Double // Rating from 0 to 5
    let maxRating: Int = 5
    var size: CGFloat = 16
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<maxRating, id: \.self) { index in
                starImage(for: index)
                    .foregroundStyle(.yellow)
                    .font(.system(size: size))
            }
        }
    }
    
    @ViewBuilder
    private func starImage(for index: Int) -> some View {
        let fillAmount = min(max(rating - Double(index), 0), 1)
        
        if fillAmount >= 1 {
            Image(systemName: "star.fill")
        } else if fillAmount > 0 {
            Image(systemName: "star.leadinghalf.filled")
        } else {
            Image(systemName: "star")
        }
    }
}
