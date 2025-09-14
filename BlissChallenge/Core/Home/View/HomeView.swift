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
                Image("preview")
                    .scaledToFit()
                
                CustomButtonView(text: "Random Emoji") {
                    
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
