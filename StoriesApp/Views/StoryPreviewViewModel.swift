//
//  StoryPreviewViewModel.swift
//  StoriesApp
//
//  Created by Artemis Shlesberg on 11/4/25.
//

import Foundation
import Combine

final class StoryPreviewViewModel: ObservableObject {
    @Published var currentUserIndex: Int = 0
    @Published var currentIndex: Int = 0
    var stories: [StoryData]
    var user: User
    
    let feedViewModel: StoriesFeedViewModel
    private var cancelable = Set<AnyCancellable>()
    
    init(storyEntry: UserStoryEntry, feedViewModel: StoriesFeedViewModel) {
        self.user = storyEntry.user
        self.stories = storyEntry.stories
        self.feedViewModel = feedViewModel
        self.currentUserIndex = feedViewModel.storyItems.firstIndex(where: { entry in
            entry.user.id == user.id
        }) ?? 0
    }

    var currentStory: StoryData? {
        guard currentIndex < stories.count else { return nil }
        print(currentIndex)
        print(stories[currentIndex].id)
        return stories[currentIndex]
    }

    func markCurrentAsSeen() {
        if let id = currentStory?.id {
            feedViewModel.markStorySeen(id)
        }
    }

    func toggleLike() {
        if let id = currentStory?.id {
            feedViewModel.toggleLike(for: id)
        }
    }

    func isLiked(_ id: String) -> Bool {
        feedViewModel.isLiked(id)
    }

    func goToNext() {
        if currentIndex < stories.count - 1 {
            currentIndex += 1
        } else {
            if currentUserIndex < feedViewModel.storyItems.count - 1 {
                currentIndex = 0
                currentUserIndex += 1
                user = feedViewModel.storyItems[currentUserIndex].user
                stories = feedViewModel.storyItems[currentUserIndex].stories
            } else {
                Task {
                    await feedViewModel.loadNextPage()
                    DispatchQueue.main.async {
                        self.goToNext()
                    }
                }
            }
        }
    }

    func goToPrevious() {
        if currentIndex > 0 {
            currentIndex -= 1
        } else {
            if currentUserIndex > 0 {
                currentIndex = 0
                currentUserIndex -= 1
                user = feedViewModel.storyItems[currentUserIndex].user
                stories = feedViewModel.storyItems[currentUserIndex].stories
            }
        }
    }
}
