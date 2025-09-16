//
//  EmojiRepository.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 15/09/25.
//


import Foundation
import SwiftData

final class EmojiRepository {
    private let remote: EmojiRemoteDataSource
    private let local: EmojiLocalDataSource

    init(apiRepository: EmojiRemoteDataSource, cacheRepository: EmojiLocalDataSource) {
        self.remote = apiRepository
        self.local = cacheRepository
    }
    func fetchEmojis() async throws -> [Emoji] {
        let cached = try await local.fetchEmojis()
        if !cached.isEmpty {
            return cached
            
        }

        let remote = try await remote.fetchEmojis()
        try await local.saveEmojis(remote)
        return remote
    }

    func fetchImage(for emoji: Emoji) async throws -> Data? {
      
        if let data = emoji.imageData {
            return data
        }

        guard let data = try await remote.fetchImage() else {
            return nil
        }

     
        try await local.saveImageData(for: emoji, imageData: data)
        return data
    }
    func refreshEmojis() async throws {
        try await local.clearCache()
        let remote = try await remote.fetchEmojis()
        try await local.saveEmojis(remote)
    }

}
