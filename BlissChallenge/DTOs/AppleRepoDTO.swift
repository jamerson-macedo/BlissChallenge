//
//  RepoDTO.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 15/09/25.
//

import Foundation

struct AppleRepoDTO:Identifiable,Decodable {
    let id: Int
    let fullName: String
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
    }
}
