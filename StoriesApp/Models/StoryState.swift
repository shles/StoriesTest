//
//  StoryState.swift
//  StoriesApp
//
//  Created by Artemis Shlesberg on 11/4/25.
//

import Foundation
import SwiftData

@Model
final class StoryState {
    var storyID: String
    var isSeen: Bool
    var isLiked: Bool
    
    init(storyID: String, isSeen: Bool = false, isLiked: Bool = false) {
        self.storyID = storyID
        self.isSeen = isSeen
        self.isLiked = isLiked
    }
}
