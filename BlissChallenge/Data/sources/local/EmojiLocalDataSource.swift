//
//  EmojiCacheRepository.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 15/09/25.
//

import SwiftData
import Foundation

final class EmojiLocalDataSource {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchEmojis() throws -> [Emoji] {
        print("Fetch from cache")
        let descriptor = FetchDescriptor<Emoji>()
        return try modelContext.fetch(descriptor)
    }
    
    func saveEmojis(_ emojis: [Emoji]) throws {
        for emoji in emojis {
            if try !exists(emoji) {
                modelContext.insert(emoji)
            }
        }
        print("saved on Cache")
        try modelContext.save()
    }
    
    private func exists(_ emoji: Emoji) throws -> Bool {
        let id = emoji.id
        let descriptor = FetchDescriptor<Emoji>(predicate: #Predicate { $0.id == id })
        let results = try modelContext.fetch(descriptor)
        return !results.isEmpty
    }
    
    func saveImageData(for emoji: Emoji, imageData: Data) throws {
        let id = emoji.id
        let descriptor = FetchDescriptor<Emoji>(predicate: #Predicate { $0.id == id })
        guard let storedEmoji = try modelContext.fetch(descriptor).first else {
            let newEmoji = Emoji(id: emoji.id, url: emoji.url, imageData: imageData)
            modelContext.insert(newEmoji)
            try modelContext.save()
            return
        }
        storedEmoji.imageData = imageData
        try modelContext.save()
    }
    func clearCache() throws {
        let descriptor = FetchDescriptor<Emoji>()
        let emojis = try modelContext.fetch(descriptor)
        emojis.forEach { emoji in
            modelContext.delete(emoji)
        }
        try modelContext.save()
        print("Cache cleared")
    }
}
