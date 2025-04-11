//
//  UserStoryEntry.swift
//  StoriesApp
//
//  Created by Artemis Shlesberg on 11/4/25.
//

import Foundation

struct UserStoryEntry: Codable {
    let user: User
    let stories: [StoryData]
}

