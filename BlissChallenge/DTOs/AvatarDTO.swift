//
//  AvatarDTO.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 15/09/25.
//


struct AvatarDTO: Decodable {
    let login: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}
