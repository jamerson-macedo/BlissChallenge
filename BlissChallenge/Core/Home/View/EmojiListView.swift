//
//  EmojiListView.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 13/09/25.
//

import SwiftUI
import SwiftData
struct EmojiListView: View {
    @Bindable var viewModel: HomeViewModel
    let repository: EmojiRepository
    init(viewModel: HomeViewModel, repository: EmojiRepository) {
        self.repository = repository
        self._viewModel = Bindable(viewModel)
    }

    let gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 10) {
                    ForEach(viewModel.emojiList) { emoji in
                        if let imageData = emoji.imageData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .onTapGesture {
                                    viewModel.removeEmoji(emoji)
                                }
                        } else {
                            if let url = URL(string: emoji.url) {
                                AsyncImage(url: url) { result in
                                    switch result {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                viewModel.removeEmoji(emoji)
                                            }
                                    case .failure(_):
                                        Image(systemName: "xmark")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.red)
                                            .frame(width: 50, height: 50)
                                    default:
                                        ProgressView()
                                            .frame(width: 50, height: 50)
                                    }
                                }
                            } else {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }
                        }
                    }
                }
            }
            .refreshable {
                await viewModel.loadEmojis()
            }
        }
    }
}
