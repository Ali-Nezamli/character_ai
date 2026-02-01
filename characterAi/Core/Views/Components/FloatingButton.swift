//
//  FloatingButton.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 01/02/2026.
//

import SwiftUI

struct FloatingActionButton: View {
    let action: () -> Void
    var icon: String = "plus"
    var backgroundColor: Color = .blue
    var size: CGFloat = 60
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: size * 0.4))
                .foregroundStyle(.white)
                .frame(width: size, height: size)
                .background(backgroundColor)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
        }
    }
}
