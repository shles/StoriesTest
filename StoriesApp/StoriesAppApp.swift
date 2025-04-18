//
//  StoriesAppApp.swift
//  StoriesApp
//
//  Created by Artemis Shlesberg on 11/4/25.
//

import SwiftUI
import SwiftData

@main
struct StoriesAppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            StoryState.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomeFeedView()
        }
        .modelContainer(sharedModelContainer)
    }
}
