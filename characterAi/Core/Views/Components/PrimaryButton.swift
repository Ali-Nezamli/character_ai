//
//  PrimaryButton.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 01/02/2026.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)
                .frame(
                    maxWidth: width == nil ? .infinity : nil,
                    minHeight: height
                )
                .frame(width: width)
                .padding(.vertical, height == nil ? 18 : 0)
                .background(
                    LinearGradient(
                        colors: [Color(hex: "7C3AED"), Color(hex: "4F46E5")],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(16)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
}
