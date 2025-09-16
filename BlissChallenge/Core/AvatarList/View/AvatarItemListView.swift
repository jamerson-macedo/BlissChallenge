//
//  AvatarView.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 15/09/25.
//
import SwiftUI

struct AvatarItemListView: View {
    var avatar: AvatarDTO
    
    var body: some View {
        VStack{
        AsyncImage(url: URL(string: avatar.avatarURL)) { result in
            switch result {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
            case .failure(_):
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.red)
                    .frame(width: 50, height: 50)
            default:
                ProgressView()
                    .frame(width: 40, height: 50)
            }
        }
        Text(avatar.login)
            .font(.headline)
            .bold()
            .padding(5)
    }
    }
}
