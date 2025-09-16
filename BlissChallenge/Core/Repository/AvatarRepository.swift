//
//  AvatarRepository.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 16/09/25.
//


import SwiftData
import Foundation
@MainActor
final class AvatarRepository {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func saveAvatar(from dto: AvatarDTO) async {
        guard let url = URL(string: dto.avatarURL) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let avatar = Avatar(
                login: dto.login, avatarURL: dto.avatarURL,
                imageData: data
            )
            
            context.insert(avatar)
            try? context.save()
            print("Saved Avatar")
        } catch {
            print("❌ Error download image: \(error)")
        }
    }
    
    func fetchAllAvatars() -> [Avatar] {
        let descriptor = FetchDescriptor<Avatar>()
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func deleteAvatar(_ avatar: Avatar) {
        context.delete(avatar)
        try? context.save()
    }
}
