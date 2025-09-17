//
//  AvatarRowView.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 16/09/25.
//

import SwiftUI
struct AvatarRowView: View {
    let avatar: Avatar
    @Bindable var avatarViewModel: AvatarViewModel

    var body: some View {
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
