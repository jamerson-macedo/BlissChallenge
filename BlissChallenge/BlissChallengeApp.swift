//
//  BlissChallengeApp.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 13/09/25.
//

import SwiftUI
import SwiftData

@main
struct BlissChallengeApp: App {
    
    let container: ModelContainer
    
    init() {
        let schema = Schema([Emoji.self, Avatar.self])
        let config = ModelConfiguration(isStoredInMemoryOnly: false)
        do {
            container = try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Could not configure the container: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(container: container)
                .onAppear {
                    print("path:", URL.documentsDirectory.path())
                }
        }
        .modelContainer(container)
    }
}

