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
        let schema = Schema([Emoji.self])
        do {
            container = try ModelContainer(for: schema)
        } catch {
            fatalError("Could not configure the container: \(error)")
        }
    }
    var body: some Scene {
        WindowGroup {
            HomeView(container: container)
                .onAppear {
                    print(URL.documentsDirectory.path())
                }
        }
        .modelContainer(container)
    }
}
