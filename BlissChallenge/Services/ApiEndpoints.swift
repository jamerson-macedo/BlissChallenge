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
    
    var url: URL? {
        switch self {
        case .emojis:
            return URL(string: "\(Self.baseURL)/emojis")
        }
    }
}
