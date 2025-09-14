//
//  Emoji.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 14/09/25.
//

import Foundation
struct Emoji: Identifiable,Equatable {
    var id:String
    let url : String
}
extension Emoji {
    static func from(api: ApiResponse) -> [Emoji] {
        api.map { key, value in
            Emoji(id: key, url: value)
        }
    }
}
