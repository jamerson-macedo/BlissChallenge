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
    
    private let repository: EmojiRepository
       
       init(repository: EmojiRepository) {
           self.repository = repository
       }
    
    var emoji : Emoji?
    var emojiList : [Emoji] = []
    
    func loadEmojis() async {
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
        }
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
