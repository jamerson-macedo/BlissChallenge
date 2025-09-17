//
//  WebService.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 14/09/25.
//

import Foundation

typealias ApiResponse = [String:String]

final class EmojiService{
    
    static let shared = EmojiService()
    private init(){}
    
    func fetchEmojis() async throws ->[Emoji]{
        guard let url = GitHubApiEndPoints.emojis.url else { throw NetworkError.badURL}
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let apiResponse = try? JSONDecoder().decode(ApiResponse.self, from: data) else {
                throw NetworkError.decodingError
            }
            print("fetching from Api")
            return Emoji.from(api: apiResponse)
            
        }catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.custom("Unknown error")
        }
    }
    func fetchImage() async throws -> Data? {
        guard let url = GitHubApiEndPoints.emojis.url else { throw NetworkError.badURL}
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
}
