//
//  Emoji 2.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 15/09/25.
//

import Foundation
import SwiftData

@Model

class Emoji: Identifiable, Equatable,@unchecked Sendable {
    var id: String
    var url: String
    @Attribute(.externalStorage)
    var imageData: Data?
    init(id: String, url: String, imageData: Data? = nil) {
        self.id = id
        self.url = url
        self.imageData = imageData
    }
    
    static func from(api: ApiResponse) -> [Emoji] {
        api.map { key, value in
            Emoji(id: key, url: value, imageData: nil)
        }
    }
}
