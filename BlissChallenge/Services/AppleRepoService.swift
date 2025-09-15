//
//  AppleRepoService.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 15/09/25.
//

import Foundation

final class AppleRepoService{
    
    static let shared = AppleRepoService()
    private init(){}
    
    func fetchRepos(page: Int, perPage: Int = 10) async throws -> [AppleRepo] {
        guard let url = APIEndpoint.repos(username: "apple", page: page, perPage: perPage).url else {
            throw NetworkError.badURL
            
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.custom("Erro in Response")
        }
        if httpResponse.statusCode == 200 {
            let appleRepo = try JSONDecoder().decode([AppleRepoDTO].self, from: data)
            
            let repos = appleRepo.map {
                AppleRepo(
                    id: $0.id,
                    fullName: $0.fullName.replacingOccurrences(of: "apple/", with: "") //
                )
            }
            return repos
        } else if httpResponse.statusCode == 404 {
            throw NetworkError.custom("Repo not Found !")
        } else {
            throw NetworkError.custom("Error unknown")
        }
    }
}
