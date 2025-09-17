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
    var avatar: Avatar?
    var isLoading: Bool = false
    var avatars: [Avatar] = []
    
    let repository: AvatarRepository
    
    init(repository: AvatarRepository) {
        self.repository = repository
    }
    
    func fetchAvatar() async {
        let query = search
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        
        guard !query.isEmpty else { return }
        
        isLoading = true
        
        if let avatar = await repository.getAvatar(login: query) {
            self.avatar = avatar
            self.avatars = [avatar]
        } else {
            self.errormessage = "Failed to load avatar. Avatar not Found."
        }
        self.isLoading = false
        search = ""
    }
    
    func loadAvatars() async {
        avatars = repository.getAllAvatars()
    }
    
    func deleteAvatar(avatar: Avatar) async {
        isLoading = true
        repository.deleteAvatar(avatar)
        await loadAvatars()
        isLoading = false
    }
    func deleteAllAvatars() async {
        isLoading = true
        repository.deleteAllAvatars()
        await loadAvatars()
        isLoading = false
    }
}
