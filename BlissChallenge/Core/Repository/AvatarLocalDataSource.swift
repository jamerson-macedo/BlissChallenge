//
//  AvatarRepository.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 16/09/25.
//

import SwiftData
import Foundation

final class AvatarLocalDataSource {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchAvatar(login: String) -> Avatar? {
        let descriptor = FetchDescriptor<Avatar>(
            predicate: #Predicate { $0.login == login }
        )
        return try? context.fetch(descriptor).first
    }
    
    func fetchAllAvatars() -> [Avatar] {
        let descriptor = FetchDescriptor<Avatar>()
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func saveAvatar(_ avatar: Avatar) {
        context.insert(avatar)
        try? context.save()
    }
    
    func deleteAvatar(_ avatar: Avatar) {
        context.delete(avatar)
        try? context.save()
    }
    
    func deleteAllAvatars() {
        let descriptor = FetchDescriptor<Avatar>()
        if let avatars = try? context.fetch(descriptor) {
            for avatar in avatars { context.delete(avatar) }
            try? context.save()
        }
    }
}
