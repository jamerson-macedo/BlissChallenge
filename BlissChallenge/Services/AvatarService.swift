//
//  AvatarService.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 15/09/25.
//

import Foundation

final class AvatarService{
    
    static let shared = AvatarService()
    private init(){}
    
    func fetchAvatar(query: String) async throws -> AvatarDTO {
        guard let url = GitHubApiEndPoints.avatar(query).url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.custom("Erro in Response")
        }
        if httpResponse.statusCode == 200 {
            print("Get Avatar from API")
            return try JSONDecoder().decode(AvatarDTO.self, from: data)
        } else if httpResponse.statusCode == 404 {
            throw NetworkError.custom("User not Found !")
        } else {
            throw NetworkError.custom("Error unknown")
        }
    }
}

