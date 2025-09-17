//
//  HomeViewModel.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 13/09/25.
//

import Foundation
import Observation

@Observable
@MainActor final class HomeViewModel {
    
    var goToList : Bool = false
    var goToAvatar : Bool = false
    var gotoRepo : Bool = false
    var errorMessage : String?
    var isLoading : Bool = false
    private let repository: EmojiRepository
    
    init(repository: EmojiRepository) {
        self.repository = repository
    }
    var emoji : Emoji?
    var emojiList : [Emoji] = []
    func loadEmojis() async {
        self.isLoading = true
        do {
            let emojis = try await repository.fetchEmojis()
            self.emojiList = emojis
            
            for (index, emoji) in emojis.enumerated() {
                if let imageData = try await repository.fetchImage(for: emoji) {
                    DispatchQueue.main.async {
                        self.emojiList[index].imageData = imageData
                    }
                }
            }
        } catch {
            self.errorMessage = "Not possible to load emojis"
            self.isLoading = false
        }
        self.isLoading = false
    }
    func refreshEmojis() async {
        self.isLoading = true
        do {
            
            try await repository.clearCache()
            await loadEmojis()
        } catch {
            self.errorMessage = "Error refreshing emojis"
        }
        self.isLoading = false
    }
    
    
    
    func generateRandomEmoji() {
        if let randomEmoji = emojiList.randomElement() {
            self.emoji = randomEmoji
        }
    }
    
    func removeEmoji(_ emoji: Emoji) {
        emojiList.removeAll { $0.id == emoji.id }
    }
}
