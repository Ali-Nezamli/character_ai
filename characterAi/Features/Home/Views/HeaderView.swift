//
//  HeaderView.swift
//  pass2pastios
//
//  Created by Ali Nezamli on 29/01/2026.
//

import SwiftUI


struct HeaderView: View {
    var body: some View {
        HStack {
            Image(AppIcons.mainLogo)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(.circle)
            Text("BBrain")
                .font(.system(size: 20))
                .foregroundStyle(.white)
            Spacer()
            HStack {
                Image(AppIcons.gemsIcon)
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("255")
                    .foregroundStyle(.white)
            }.padding()
                .background(.gray.opacity(0.2))
                .cornerRadius(10)
        }
        HStack(spacing: 0) {
            Text("Welcome, ")
                .font(.system(size: 30, weight: .light))
            Text("Ali Nezamli")
                .font(.system(size: 30, weight: .bold))
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
