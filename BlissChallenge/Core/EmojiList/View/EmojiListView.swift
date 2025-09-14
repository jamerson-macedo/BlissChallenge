//
//  EmojiListView.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 13/09/25.
//

import SwiftUI

struct EmojiListView: View {
    @State var viewModel : HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    let gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        VStack{
            ScrollView{
                LazyVGrid(columns: gridItems, spacing: 10) {
                    ForEach(viewModel.emojiList) { emoji in
                        
                        if let url = URL(string: emoji.url) {
                            
                            AsyncImage(url: url) { result in
                                
                                switch result {
                                    
                                case.success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    
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
                        }
                    }
                    
                }
            }
        }
    }
}

#Preview {
    EmojiListView(viewModel: HomeViewModel())
}
