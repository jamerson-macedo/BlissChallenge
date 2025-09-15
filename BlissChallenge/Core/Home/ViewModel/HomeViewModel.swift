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
  
    
    var emoji : Emoji?
    var emojiList : [Emoji] = []
    
    func loadEmojis() async {
        do{
            let emojis = try await EmojiService.shared.fetchEmojis()
            self.emojiList = emojis
        }catch{
            self.errorMessage = "Not possible load emojis"
        }
     
    }
    func generateRandomEmoji() {
        if let randomEmoji = emojiList.randomElement() {
            self.emoji = randomEmoji
        }
    }
}
