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
final class AppleRepoViewModel {
    var repo: [AppleRepo] = []
    var currentPage: Int = 1
    var isLoading: Bool = false
    var errormessage: String?
    
    func fetchAppleRepo() async {
        guard !isLoading else { return }
        
        isLoading = true
        do {
            let newRepos = try await AppleRepoService.shared.fetchRepos(page: currentPage)
            
            if currentPage == 1 {
                repo = newRepos
            } else {
                repo.append(contentsOf: newRepos)
            }
            
            currentPage += 1
        } catch {
            self.errormessage = error.localizedDescription
        }
        isLoading = false
    }
}

