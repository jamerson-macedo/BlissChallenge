//
//  ContentView.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 13/09/25.
//

import SwiftUI

struct HomeView: View {
    @State private var homeViewModel: HomeViewModel = .init()
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 10){
                VStack {
                    if let emoji = homeViewModel.emoji {
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
                .frame(height: 100)
                .padding(.bottom,30)
                
                CustomButtonView(text: "Random Emoji") {
                    withAnimation {
                        homeViewModel.generateRandomEmoji()
                    }
                   
                }
                CustomButtonView(text: "Emojis List") {
                    homeViewModel.goToList.toggle()
                }
                HStack{
                    SearchBar(text: $homeViewModel.search)
                    
                    CustomButtonView(text: "Search Emoji") {
                        
                    }
                }
                CustomButtonView(text: "Avatar List") {
                    homeViewModel.goToAvatar.toggle()
                }
                CustomButtonView(text: "Apple Repos") {
                    homeViewModel.gotoRepo.toggle()
                }
                
            }
            .navigationTitle("Emoji")
            .navigationDestination(isPresented:$homeViewModel.goToList, destination: {
                EmojiListView(viewModel: homeViewModel)
            })
            .navigationDestination(isPresented:$homeViewModel.goToAvatar, destination: {
                AvatarListView()
            })
            .navigationDestination(isPresented:$homeViewModel.gotoRepo, destination: {
                AppleRepoView()
            })
            .task {
                await homeViewModel.loadEmojis()
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    NavigationStack{
        HomeView()
    }
}
