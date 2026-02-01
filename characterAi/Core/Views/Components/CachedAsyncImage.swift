//
//  Untitled.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 29/01/2026.
//
import SwiftUI

struct CachedAsyncImage: View {
    let url: String
    let contentMode: ContentMode
    let cornerRadius: CGFloat
    let isCircled: Bool
    
    enum ContentMode {
        case fill
        case fit
    }
    
    init(
        url: String,
        contentMode: ContentMode = .fill,
        cornerRadius: CGFloat = 0,
        isCircled: Bool = false
    ) {
        self.url = url
        self.contentMode = contentMode
        self.cornerRadius = cornerRadius
        self.isCircled = isCircled
    }
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ZStack {
                    Color.gray.opacity(0.2)
                    ProgressView()
                }
                
            case .success(let image):
                image
                    .resizable()
                    .applyContentMode(contentMode)
                
            case .failure:
                ZStack {
                    Color.gray.opacity(0.2)
                    Image(systemName: "photo.fill")
                        .font(.system(size: 40))
                        .foregroundStyle(.gray)
                }
                
            @unknown default:
                EmptyView()
            }
        }
        .clipped()
        .applyShape(isCircled: isCircled, cornerRadius: cornerRadius)
    }
}

// MARK: - Extensions
extension View {
    @ViewBuilder
    func applyContentMode(_ mode: CachedAsyncImage.ContentMode) -> some View {
        switch mode {
        case .fill:
            self.scaledToFill()
        case .fit:
            self.scaledToFit()
        }
    }
    
    @ViewBuilder
    func applyShape(isCircled: Bool, cornerRadius: CGFloat) -> some View {
        if isCircled {
            self.clipShape(Circle())
        } else if cornerRadius > 0 {
            self.clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        } else {
            self
        }
    }
}
