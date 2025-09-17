//
//  AvatarViewModel.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 15/09/25.
//

import Foundation
import Observation

@Observable
@MainActor
final class AvatarViewModel {
    var search = ""
    var errormessage: String? = nil
    var avatar: AvatarDTO?
    var isLoading: Bool = false
    var avatars : [Avatar] = []
    let repository: AvatarRepository
    
    init(repository: AvatarRepository) {
        self.repository = repository
    }
    
    func fetchAvatar() async {
        self.isLoading = true
        let query = search
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        
        do {
            avatar = try await AvatarService.shared.fetchAvatar(query: query)
            
            if let avatar {
                await repository.saveAvatar(from: avatar)
            }
            
        } catch {
            self.errormessage = "Failed to load avatar. Avatar not Found."
        }
        
        search = ""
        self.isLoading = false
    }
    
    func loadAvatars() async {
        avatars =  repository.fetchAllAvatars()
    }
    func deleteAvatar(avatar : Avatar) async {
        self.isLoading = true
        repository.deleteAvatar(avatar)
        await loadAvatars()
        self.isLoading = false
    }
    func deleteAllAvatars() async {
          isLoading = true
          repository.deleteAllAvatars()
          await loadAvatars()
          isLoading = false
      }
}

