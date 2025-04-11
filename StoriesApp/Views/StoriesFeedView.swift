//
//  StoriesFeedView.swift
//  StoriesApp
//
//  Created by Artemis Shlesberg on 11/4/25.
//

import SwiftUI
import SwiftData

struct StoriesFeedView: View {
    
    @Environment(\.modelContext) private var context
    @StateObject var viewModel: StoriesFeedViewModel

//    init() {
//        _viewModel = StateObject(wrappedValue: StoriesFeedViewModel(context: ModelContext.preview))
//    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewModel.storyItems, id: \.user.id) { item in
                    StoryItemView(storyItem: item, viewModel: viewModel)
                        .frame(width:100, height: 100)
                        .onAppear {
                            if item.user.id == viewModel.storyItems.last?.user.id {
                                Task {
                                    await viewModel.loadNextPage()
                                }
                            }
                        }
                }
            }
            .frame(height: 100)
            .padding()
        }
        .scrollIndicators(.hidden)
    }
}

struct StoryItemView: View {
    let storyItem: UserStoryEntry
    @StateObject var viewModel: StoriesFeedViewModel
    
    @State private var showPreview = false
    var body: some View {
        Button {
                    showPreview = true
        } label: {
            ZStack {
                AsyncImage(url: URL(string: storyItem.user.photoURLString)) { image in
                    image.resizable()
                } placeholder: {
                    Circle().fill(Color.gray)
                    
                }
                .cornerRadius(50)

            }
            .overlay(
                Circle()
                    .stroke(viewModel.hasSeenAllStories(for: storyItem) ? .gray : .blue, lineWidth: 2)
            )
        }
        .fullScreenCover(isPresented: $showPreview) {
                    StoryPreviewView(
                        viewModel: StoryPreviewViewModel(storyEntry: storyItem, feedViewModel: viewModel)
                    )
                }
    }
}

#Preview {
    StoriesFeedView(viewModel: StoriesFeedViewModel(context: DataController.previewContext))
        .modelContainer(DataController.previewContainer)
}
