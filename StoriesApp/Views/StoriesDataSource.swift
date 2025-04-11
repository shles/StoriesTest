//
//  StoriesDataSource.swift
//  StoriesApp
//
//  Created by Artemis Shlesberg on 11/4/25.
//

import Foundation

import Foundation

class StoryFeedDataSource {
    private var entries: [UserStoryEntry] = []
    private var currentIndex: Int = 0
    private let pageSize = 10

    init(entries: [UserStoryEntry]) {
        self.entries = entries
    }
    
    init() {
        loadInitialData()
    }
    

    func nextPage() -> [UserStoryEntry] {
        guard !entries.isEmpty else { return [] }
        
        let entry = entries.dropFirst(currentIndex).prefix(pageSize)
        currentIndex += entry.count
        return Array(entry)
    }
    
    func loadInitialData() {
        if let url = Bundle.main.url(forResource: "stories", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            if let entry = loadUserStoryEntry(from: data) {
                entries = entry.sorted {
                    let firstMostRecent = $0.stories.max(by: { $0.timestamp < $1.timestamp })?.timestamp ?? .distantPast
                    let secondMostRecent = $1.stories.max(by: { $0.timestamp < $1.timestamp })?.timestamp ?? .distantPast
                    return firstMostRecent > secondMostRecent
                }
            }
        }
    }
    
    func loadUserStoryEntry(from jsonData: Data) -> [UserStoryEntry]? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            let entry = try decoder.decode([UserStoryEntry].self, from: jsonData)
            return entry
        } catch {
            print("Decoding error: \(error)")
            return nil
        }
    }

    func reset() {
        currentIndex = 0
    }
}

class InfiniteStoryDataSource {
    private var baseData: [UserStoryEntry] = []
    private var currentPage = 0
    
    init() {
        loadInitialData()
    }
    
    func loadNextPage() -> [UserStoryEntry] {
        currentPage += 1
        return baseData.map { entry in
            let newUserId = entry.user.id + currentPage * 1000
            let newUser = User(
                id: newUserId,
                photoURLString: "https://i.pravatar.cc/300?u=\(newUserId)",
                name: "User \(newUserId)"
            )
            
            let newStories = entry.stories.map { story in
                let uniqueStoryId = "p\(currentPage)_\(story.id)_\(UUID().uuidString.prefix(4))"
                return StoryData(
                    id: uniqueStoryId,
                    image_url: story.image_url,
                    timestamp: story.timestamp
                )
            }
            
            return UserStoryEntry(user: newUser, stories: newStories)
        }
    }

    private func loadInitialData() {
        guard let url = Bundle.main.url(forResource: "stories", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Failed to load stories.json")
            return
        }
        
        do {
            baseData = try JSONDecoder().decode([UserStoryEntry].self, from: data)
        } catch {
            print("Decoding error: \(error)")
        }
    }
}
