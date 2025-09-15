//
//  ContentView.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 13/09/25.
//

import SwiftUI

struct HomeView: View {
    @State var homeViewModel: HomeViewModel = .init()
    @State var avatarViewModel: AvatarViewModel = .init()
    
    @State private var showAvatar = false
    @State private var showEmoji = true
    
    var body: some View {
        NavigationStack {
            VStack{
                VStack(spacing: 10) {
                    VStack {
                        if showAvatar, let avatar = avatarViewModel.avatar {
                            AvatarView(avatar: avatar)
                        }
                        if let errorMessage = avatarViewModel.errormessage {
                            ErrorMessageView(message: errorMessage)
                        }
                    }
                    .onChange(of: avatarViewModel.errormessage) { _,_ in
                        if avatarViewModel.errormessage != nil {
                            showAvatar = false
                        }
                    }
                    
                    if showEmoji, let emoji = homeViewModel.emoji {
                        EmojiView(emoji: emoji)
                    }
                }
                .frame(height: 100)
                .padding(.bottom, 30)
                
                CustomButtonView(text: "Random Emoji") {
                    showRandomEmoji()
                }
                CustomButtonView(text: "Emojis List") {
                    homeViewModel.goToList.toggle()
                }
                HStack {
                    SearchBar(text: $avatarViewModel.search)
                        .submitLabel(.search)
                        .onSubmit {
                            Task {
                                await avatarViewModel.fetchAvatar()
                                updateAvatarView()
                            }
                        }
                    
                    CustomButtonView(text: "Search Avatar") {
                        Task {
                            await avatarViewModel.fetchAvatar()
                            updateAvatarView()
                        }
                    }
                    .disabled(avatarViewModel.search.isEmpty ? true : false)
                    .opacity(avatarViewModel.search.isEmpty ? 0.5 : 1)
                }
                CustomButtonView(text: "Avatar List") {
                    homeViewModel.goToAvatar.toggle()
                }
                CustomButtonView(text: "Apple Repos") {
                    homeViewModel.gotoRepo.toggle()
                }
            } .navigationTitle("Emoji")
                .navigationDestination(isPresented: $homeViewModel.goToList, destination: {
                    EmojiListView(viewModel: homeViewModel)
                })
                .navigationDestination(isPresented: $homeViewModel.goToAvatar, destination: {
                    AvatarListView()
                })
                .navigationDestination(isPresented: $homeViewModel.gotoRepo, destination: {
                    AppleRepoView()
                })
        }
        .task {
            await homeViewModel.loadEmojis()
        }
        .padding(.horizontal)
    }
    
    private func updateAvatarView() {
        if avatarViewModel.avatar != nil {
            showAvatar = true
            showEmoji = false
        } else {
            showAvatar = false
            showEmoji = true
        }
    }

    private func showRandomEmoji() {
        withAnimation {
            homeViewModel.generateRandomEmoji()
            showAvatar = false
            avatarViewModel.errormessage = nil
            showEmoji = true
        }
    }
}







#Preview {
    NavigationStack {
        HomeView()
    }
}

