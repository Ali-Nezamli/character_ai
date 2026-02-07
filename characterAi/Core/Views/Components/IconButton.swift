//
//  IconButton.swift
//  characterAi
//
//  Created by Ali Nezamli on 07/02/2026.
//

import SwiftUI

struct IconButton: View {
    let icon: String
    let action: () -> Void
    var size: CGFloat = 24
    var color: Color = .primary
    var backgroundColor: Color? = nil
    var padding: CGFloat = 8
    var borderColor: Color? = nil
    var borderWidth: CGFloat = 1
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .foregroundColor(color) // Change this
                .padding(padding)
                .background(
                    backgroundColor.map { bgColor in
                        Circle().fill(bgColor)
                    }
                )
                .overlay(
                    borderColor.map { bColor in
                        Circle()
                            .stroke(bColor, lineWidth: borderWidth)
                    }
                )
        }
        .buttonStyle(.plain)
    }
}
