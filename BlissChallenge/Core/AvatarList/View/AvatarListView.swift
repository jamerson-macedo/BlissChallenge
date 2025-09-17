//
//  AvatarListView.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 13/09/25.
//

import SwiftUI

struct AvatarListView: View {
    @Bindable var avatarViewModel: AvatarViewModel
    
    init(avatarViewModel: AvatarViewModel) {
        self._avatarViewModel = Bindable(avatarViewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if avatarViewModel.avatars.isEmpty {
                    ContentUnavailableView("No avatars found", systemImage: "person.circle")
                } else {
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(avatarViewModel.avatars, id: \.id) { avatar in
                                AvatarRowView(avatar: avatar, avatarViewModel: avatarViewModel)
                                    .transition(.move(edge: .leading).combined(with: .opacity))
                                    .animation(.easeInOut, value: avatarViewModel.avatars)
                                
                            }
                        }.padding()
                    }.refreshable {
                        await avatarViewModel.deleteAllAvatars()
                    }
                }
            }
            .navigationTitle("Avatars")
            .navigationBarTitleDisplayMode(.inline)
            .alert(
                "Error",
                isPresented: Binding(
                    get: { avatarViewModel.errormessage != nil },
                    set: { _ in avatarViewModel.errormessage = nil }
                )
            ) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(avatarViewModel.errormessage ?? "Unknown error")
            }
            .task {
                await avatarViewModel.loadAvatars()
            }
        }
    }
}

#Preview("Avatar ListView") {
    let preview = Preview(Avatar.self)
    preview.addExamples(Avatar.sampleAvatars)
    
    let local = AvatarLocalDataSource(context: preview.container.mainContext)
    let remote = AvatarRemoteDataSource()
    let avatarRepo = AvatarRepository(local: local, remote: remote)
    
    let avatarVM = AvatarViewModel(repository: avatarRepo)
    avatarVM.avatars = Avatar.sampleAvatars
    
    return AvatarListView(avatarViewModel: avatarVM)
        .modelContainer(preview.container)
}
