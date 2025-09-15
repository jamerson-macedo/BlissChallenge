//
//  Endpoint.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 14/09/25.
//


import Foundation

enum APIEndpoint {
    static let baseURL = "https://api.github.com"
    
    case emojis
    case avatar(String)
    case repos(username: String, page: Int, perPage: Int)
    
    var url: URL? {
        switch self {
        case .emojis:
            return URL(string: "\(Self.baseURL)/emojis")
            
        case .avatar(let login):
            return URL(string: "\(Self.baseURL)/users/\(login)")
            
        case .repos(let username, let page, let perPage):
            return URL(string: "\(Self.baseURL)/users/\(username)/repos?page=\(page)&per_page=\(perPage)")
        }
    }
}
