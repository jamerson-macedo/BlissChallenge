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
        print("fetch from Cache")
        return try? context.fetch(descriptor).first
    }
    
    func fetchAllAvatars() -> [Avatar] {
        print("Fetch All avatars")
        let descriptor = FetchDescriptor<Avatar>()
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func saveAvatar(_ avatar: Avatar) {
        print("Save on Cache")
        context.insert(avatar)
        try? context.save()
    }
    
    func deleteAvatar(_ avatar: Avatar) {
        print("Deleted from Cache: \(avatar.login)")
        context.delete(avatar)
        try? context.save()
    }
    
    func deleteAllAvatars() {
        print("Delete all avatars from Cache")
        let descriptor = FetchDescriptor<Avatar>()
        if let avatars = try? context.fetch(descriptor) {
            for avatar in avatars { context.delete(avatar) }
            try? context.save()
        }
    }
}
