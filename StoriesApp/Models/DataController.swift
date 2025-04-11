//
//  DataController.swift
//  StoriesApp
//
//  Created by Artemis Shlesberg on 11/4/25.
//

import Foundation
import SwiftData

class DataController {
    @MainActor
    static let previewContainer: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: StoryState.self, configurations: config)

            let context = container.mainContext

            for i in 1...9 {
                let mock = StoryState(
                    storyID: "story_\(i)",
                    isSeen: Bool.random(),
                    isLiked: Bool.random()
                )
                context.insert(mock)
            }

            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
    @MainActor
    static var previewContext: ModelContext {
        previewContainer.mainContext
    }
}
