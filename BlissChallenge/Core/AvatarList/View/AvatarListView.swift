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
                                HStack {
                                    if let imageData = avatar.imageData,
                                       let uiImage = UIImage(data: imageData) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(Circle())
                                            .frame(width: 80, height: 80)
                                    }

                                    VStack(alignment: .leading) {
                                        Text(avatar.login)
                                            .font(.headline)
                                    }

                                    Spacer()

                                    Button {
                                        Task {
                                            await avatarViewModel.deleteAvatar(avatar: avatar)
                                            withAnimation(.easeInOut) {
                                                avatarViewModel.avatars.removeAll { $0.id == avatar.id }
                                            }
                                        }
                                    } label: {
                                        if avatarViewModel.isLoading {
                                            ProgressView()
                                        } else {
                                            Image(systemName: "trash")
                                                .foregroundColor(.red)
                                        }
                                    }
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(10)
                                .shadow(radius: 1)
                                .transition(.move(edge: .leading).combined(with: .opacity))
                            }
                        }
                        .padding()
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
        }
        .task {
            await avatarViewModel.loadAvatars()
        }
    }
}

#Preview("Avatar ListView") {
    let preview = Preview(Avatar.self)
    preview.addExamples(Avatar.sampleAvatars)
    let avatarRepo = AvatarRepository(context: preview.container.mainContext)
    let avatarVM = AvatarViewModel(repository: avatarRepo)
    avatarVM.avatars = Avatar.sampleAvatars
return AvatarListView(avatarViewModel: avatarVM)
        .modelContainer(preview.container)
}
