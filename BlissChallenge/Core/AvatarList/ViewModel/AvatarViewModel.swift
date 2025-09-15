//
//  AvatarViewModel.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 15/09/25.
//

import Foundation
import Observation

@Observable
@MainActor final class AvatarViewModel {
    
    var search = ""
    var errormessage: String? = nil
    var avatar: AvatarDTO?
    var isLoading: Bool = false
    
    func fetchAvatar() async {
        let query = search
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        
        do {
            avatar = try await AvatarService.shared.fetchAvatar(query: query)
        } catch {
            self.errormessage = "Failed to load avatar. Avatar not Found."
        }
        
        search = "" 
    }
}
