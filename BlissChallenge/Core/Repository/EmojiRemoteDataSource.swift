//
//  EmojiAPIRepository.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 15/09/25.
//

import Foundation
final class EmojiRemoteDataSource {
    
    func fetchEmojis() async throws -> [Emoji] {
        return try await EmojiService.shared.fetchEmojis()
    }

    func fetchImage() async throws -> Data? {
        
        return try await EmojiService.shared.fetchImage()
    }
}
