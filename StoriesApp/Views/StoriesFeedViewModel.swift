//
//  StoriesFeedViewModel.swift
//  StoriesApp
//
//  Created by Artemis Shlesberg on 11/4/25.
//

import Foundation
import SwiftData

final class StoriesFeedViewModel: ObservableObject {
    @Published var storyItems: [UserStoryEntry] = []

    @Published var states: [StoryState] = []
    var context: ModelContext
    var dataSource: StoryFeedDataSource = StoryFeedDataSource()
    init(context: ModelContext) {
        self.context = context
        fetchStates()
        Task {
            await loadNextPage()
        }
    }

    func fetchStates() {
        let descriptor = FetchDescriptor<StoryState>()
        do {
            states = try context.fetch(descriptor)
        } catch {
            print("Failed to fetch states: \(error)")
        }
    }

    func markStorySeen(_ id: String) {
        updateState(for: id) { $0.isSeen = true }
    }

    func toggleLike(for id: String) {
        updateState(for: id) { $0.isLiked.toggle() }
    }

    func isSeen(_ id: String) -> Bool {
//        storyItem.stories.contains(where: { story in states.first(where: { $0.storyID == story.id })?.isSeen ?? false})
        states.first(where: { $0.storyID == id })?.isSeen ?? false
    }
    
    func hasSeenAllStories(for entry: UserStoryEntry) -> Bool {
        entry.stories.allSatisfy { isSeen($0.id) }
    }

    func isLiked(_ id: String) -> Bool {
        states.first(where: { $0.storyID == id })?.isLiked ?? false
    }

    private func updateState(for id: String, mutation: (StoryState) -> Void) {
        if let existing = states.first(where: { $0.storyID == id }) {
            mutation(existing)
        } else {
            let newState = StoryState(storyID: id)
            mutation(newState)
            context.insert(newState)
            states.append(newState)
        }
        try? context.save()
    }

    func loadNextPage() async {
        
        let data = dataSource.nextPage()
        DispatchQueue.main.async {
            if !data.isEmpty {
                self.storyItems.append(contentsOf: data)
            }
        }
        
    }
}
