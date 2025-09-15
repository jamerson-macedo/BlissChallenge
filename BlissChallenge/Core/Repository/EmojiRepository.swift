//
//  EmojiRepository.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 15/09/25.
//


import Foundation
import SwiftData

final class EmojiRepository {
    private let apiRepository: EmojiAPIRepository
    private let cacheRepository: EmojiCacheRepository

    init(apiRepository: EmojiAPIRepository, cacheRepository: EmojiCacheRepository) {
        self.apiRepository = apiRepository
        self.cacheRepository = cacheRepository
    }

    func fetchEmojis() async throws -> [Emoji] {
        let cached = try cacheRepository.fetchEmojis()
        if !cached.isEmpty {
            return cached
            
        }

        let remote = try await apiRepository.fetchEmojis()
        try cacheRepository.saveEmojis(remote)
        return remote
    }

    func fetchImage(for emoji: Emoji) async throws -> Data? {
      
        if let data = emoji.imageData {
            return data
        }

        guard let data = try await apiRepository.fetchImage() else {
            return nil
        }

     
        try cacheRepository.saveImageData(for: emoji, imageData: data)
        return data
    }

}
