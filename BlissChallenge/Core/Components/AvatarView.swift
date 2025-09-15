//
//  AvatarView.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 15/09/25.
//
import SwiftUI

struct AvatarView: View {
    var avatar: AvatarDTO
    
    var body: some View {
        AsyncImage(url: URL(string: avatar.avatarURL)) { result in
            switch result {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 150, height: 150)
            case .failure(_):
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.red)
                    .frame(width: 150, height: 150)
            default:
                ProgressView()
                    .frame(width: 150, height: 150)
            }
        }
        Text(avatar.login)
            .font(.headline)
            .bold()
            .padding(5)
    }
}
