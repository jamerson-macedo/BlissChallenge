//
//  AvatarListView.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 13/09/25.
//

import SwiftUI

struct AvatarListView: View {
    @Bindable var avatarViewModel : AvatarViewModel
    init(avatarViewModel: AvatarViewModel) {
        self._avatarViewModel = Bindable(avatarViewModel)
    }
    var body: some View {
        VStack {
            if avatarViewModel.avatars.isEmpty {
                ContentUnavailableView("No avatars found", systemImage: "person.circle")
            }else {
                List(avatarViewModel.avatars) { avatar in
                    HStack {
                        if let imageData = avatar.imageData, let uiImage = UIImage(data: imageData) {
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
                        
                        
                        Button(action: {
                            Task{
                                await avatarViewModel.deleteAvatar(avatar:avatar)
                                avatarViewModel.avatars.removeAll { $0.id == avatar.id }
                            }
                        }) {
                            if avatarViewModel.isLoading {
                                ProgressView()
                            }else{
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                .navigationTitle("Avatars")
                .navigationBarTitleDisplayMode(.inline)
            }
        }.task {
            await avatarViewModel.loadAvatars()
            
        }
    }
}

#Preview {
    
}
