//
//  EmojiView.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 15/09/25.
//
import SwiftUI

struct EmojiView: View {
    var emoji: Emoji
    
    var body: some View {
        AsyncImage(url: URL(string: emoji.url)) { result in
            switch result {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .transition(.scale.combined(with: .opacity))
                    .animation(.spring(response: 0.5, dampingFraction: 0.7), value: emoji.id)
            case .failure(_):
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.red)
                    .frame(width: 100, height: 100)
                    .transition(.opacity)
            default:
                ProgressView()
                    .frame(width: 100, height: 100)
            }
        }
        Text(emoji.id)
            .font(.headline)
            .transition(.opacity.combined(with: .slide))
            .animation(.easeInOut, value: emoji.id)
    }
}
