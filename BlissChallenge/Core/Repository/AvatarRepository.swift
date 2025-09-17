//
//  AvatarRepository 2.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 16/09/25.
//

import Foundation
import SwiftData

final class AvatarRepository {
    private let local: AvatarLocalDataSource
    private let remote: AvatarRemoteDataSource
    
    init(local: AvatarLocalDataSource, remote: AvatarRemoteDataSource) {
        self.local = local
        self.remote = remote
    }
    
    func getAvatar(login: String) async -> Avatar? {
        if let cached = local.fetchAvatar(login: login) {
            return cached
        }
        
        do {
            let dto = try await remote.fetchAvatar(query: login)
            let data = try await remote.downloadImage(from: dto.avatarURL)
            let avatar = Avatar(login: dto.login, avatarURL: dto.avatarURL, imageData: data)
            local.saveAvatar(avatar)
            return avatar
        } catch {
            print("Error fetching avatar: \(error)")
            return nil
        }
    }
    
    func getAllAvatars() -> [Avatar] {
        local.fetchAllAvatars()
    }
    
    func deleteAvatar(_ avatar: Avatar) {
        local.deleteAvatar(avatar)
    }
    
    func deleteAllAvatars() {
        local.deleteAllAvatars()
    }
    func saveAvatar(_ avatar: Avatar) {
        local.saveAvatar(avatar)
    }
}
