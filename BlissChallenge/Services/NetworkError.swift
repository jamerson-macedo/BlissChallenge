//
//  NetworkError.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 14/09/25.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case badURL
    case decodingError
    case custom(String)
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "The provided URL is invalid."
        case .decodingError:
            return "Failed to decode response data."
        case .custom(let message): return message
        }
        
    }
}
