//
//  AvatarRemoteDataSource.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 16/09/25.
//

import Foundation

final class AvatarRemoteDataSource {
    func fetchAvatar(query: String) async throws -> AvatarDTO {
        try await AvatarService.shared.fetchAvatar(query: query)
    }
    
    func downloadImage(from url: String) async throws -> Data {
        guard let url = URL(string: url) else { throw NetworkError.badURL }
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
