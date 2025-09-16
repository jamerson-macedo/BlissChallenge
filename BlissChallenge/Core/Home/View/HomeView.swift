//
//  ContentView.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 13/09/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State var homeViewModel: HomeViewModel
    @State var avatarViewModel: AvatarViewModel
    
    @State private var showAvatar = false
    @State private var showEmoji = true
    
    let modelContext: ModelContext
    let repository: EmojiRepository
    
    init(container: ModelContainer) {
        self.modelContext = container.mainContext
        let cacheRepo = EmojiLocalDataSource(modelContext: modelContext)
        let apiRepo = EmojiRemoteDataSource()
        let avatarRepo = AvatarRepository(context: modelContext)
        self.repository = EmojiRepository(apiRepository: apiRepo, cacheRepository: cacheRepo)
        _homeViewModel = State(initialValue: HomeViewModel(repository: repository))
        _avatarViewModel = State(initialValue: AvatarViewModel(repository: avatarRepo))
    }
    
    
    var body: some View {
        NavigationStack {
            VStack{
                VStack(spacing: 10) {
                    VStack {
                        if avatarViewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                .frame(width: 100, height: 100)
                        }else{
                            if showAvatar, let avatar = avatarViewModel.avatar {
                                AvatarView(avatar: avatar)
                            }
                            if showEmoji, let emoji = homeViewModel.emoji {
                                EmojiView(emoji: emoji)
                            }
                        }
                    }
                    
                }
                .frame(height: 150)
                .padding(.bottom, 30)
                
                CustomButtonView(isLoading: homeViewModel.isLoading,text: "Random Emoji") {
                    showRandomEmoji()
                }
                .opacity(homeViewModel.isLoading ? 0.5 : 1)
                .disabled(homeViewModel.isLoading ? true : false)
                
                CustomButtonView(text: "Emojis List") {
                    homeViewModel.goToList.toggle()
                }
                HStack {
                    SearchBar(text: $avatarViewModel.search)
                    
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
                    EmojiListView(viewModel: homeViewModel, repository: repository)
                })
                .navigationDestination(isPresented: $homeViewModel.goToAvatar, destination: {
                    AvatarListView(avatarViewModel: avatarViewModel)
                })
                .navigationDestination(isPresented: $homeViewModel.gotoRepo, destination: {
                    AppleRepoView()
                })
                .alert(
                    "Error",
                    isPresented: Binding(
                        get: { avatarViewModel.errormessage != nil },
                        set: { _ in avatarViewModel.errormessage = nil }
                    )
                ) {
                    Button("OK", role: .cancel) {
                        showAvatar = false
                        showEmoji = false
                        avatarViewModel.avatar = nil
                        homeViewModel.emoji = nil
                        avatarViewModel.errormessage = nil
                    }
                } message: {
                    Text(avatarViewModel.errormessage ?? "Unknown error")
                }
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

