//
//  Emoji 2.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 15/09/25.
//


import Foundation
import SwiftData

@Model
class Avatar: Identifiable, Equatable, @unchecked Sendable {
    var login: String
    var avatarURL: String
    @Attribute(.externalStorage)
    var imageData: Data?
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case imageData
    }
    init(login: String, avatarURL: String, imageData: Data? = nil) {
        self.login = login
        self.avatarURL = avatarURL
        self.imageData = imageData
    }
}


