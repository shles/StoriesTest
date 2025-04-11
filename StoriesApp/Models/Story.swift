//
//  Story.swift
//  StoriesApp
//
//  Created by Artemis Shlesberg on 11/4/25.
//

import Foundation

struct StoryData: Codable {
    let id: String
    let image_url: URL
    let timestamp: Date
}
