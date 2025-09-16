//
//  AvatarSamples.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 16/09/25.
//
import Foundation

import UIKit
extension Avatar {
    static var sampleAvatars: [Avatar] {
        let avatarsInfo: [(login: String, url: String)] = [
            ("jamerson", "https://www.w3schools.com/w3images/avatar2.png"),
            ("lucas", "https://randomuser.me/api/portraits/men/2.jpg"),
            ("ana", "https://randomuser.me/api/portraits/women/2.jpg"),
            ("maria", "https://www.w3schools.com/w3images/avatar6.png"),
            ("pedro", "https://www.w3schools.com/w3images/avatar5.png"),
            ("carla", "https://randomuser.me/api/portraits/women/4.jpg"),
            ("roberto", "https://randomuser.me/api/portraits/men/6.jpg"),
            ("luana", "https://www.w3schools.com/w3images/avatar4.png"),
            ("gabriel", "https://randomuser.me/api/portraits/men/9.jpg"),
            ("sandra", "https://www.w3schools.com/w3images/avatar3.png")
        ]
        
        return avatarsInfo.map { info in
            var imageData: Data? = nil
            if let url = URL(string: info.url), let data = try? Data(contentsOf: url) {
                imageData = data
            }
            return Avatar(login: info.login, avatarURL: info.url, imageData: imageData)
        }
    }
}
