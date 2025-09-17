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
    
    init(remote: EmojiRemoteDataSource, local: EmojiLocalDataSource) {
        self.remote = remote
        self.local = local
    }
    func fetchEmojis() async throws -> [Emoji] {
        let cached = try local.fetchEmojis()
        if !cached.isEmpty {
            return cached.sorted(by: { $0.id < $1.id })
            
        }
        let remoteEmojis = try await remote.fetchEmojis()
        let sorted = remoteEmojis.sorted(by: { $0.id < $1.id })
        try local.saveEmojis(sorted)
        return sorted
    }
    
    func fetchImage(for emoji: Emoji) async throws -> Data? {
        
        if let data = emoji.imageData {
            return data
        }
        
        guard let data = try await remote.fetchImage() else {
            return nil
        }
        
        
        try  local.saveImageData(for: emoji, imageData: data)
        return data
    }
    func clearCache() async throws {
        try  local.clearCache()
    }
    
}
