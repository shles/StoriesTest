//
//  StoryPreviewView.swift
//  StoriesApp
//
//  Created by Artemis Shlesberg on 11/4/25.
//

import SwiftUI
import Combine

struct StoryPreviewView: View {
    @ObservedObject var viewModel: StoryPreviewViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            if let story = viewModel.currentStory {
                AsyncImage(url: story.image_url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                } placeholder: {
                    Color.gray.ignoresSafeArea()
                }
                .frame(width: UIScreen.main.bounds.width)
                .id(story.id)
                GeometryReader { geometry in
                    VStack {
                        HStack {
                            
                            ForEach((0..<viewModel.stories.count), id: \.self) { index in 
                                Rectangle()
                                    .fill(index <= viewModel.currentIndex ? Color.white : Color.gray)
                                    .frame(width: geometry.size.width / CGFloat(viewModel.stories.count), height: 2)
                                
                            }
                        }
                        
                        HStack {
                            AsyncImage(url: URL(string: viewModel.user.photoURLString)) { image in
                                image.resizable()
                                
                            } placeholder: {
                                Circle().fill(Color.gray)
                            }
                            .cornerRadius(25)
                            .frame(width: 50, height: 50)
                            VStack {
                                Text(viewModel.user.name)
                                    .font(.caption)
                                    .foregroundStyle(.white)
                            }
                            Spacer()
                            Button(action: {
                                dismiss()
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(.black.opacity(0.5))
                                    .clipShape(Circle())
                            }
                        }
                        .padding()
                        Spacer()
                        Button(action: {
                            viewModel.toggleLike()
                        }) {
                            Image(systemName: viewModel.isLiked(story.id) ? "heart.fill" : "heart")
                                .foregroundColor(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(Circle())
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.markCurrentAsSeen()
        }
        .contentShape(Rectangle())
        .onTapGesture { location in
            if location.x > UIScreen.main.bounds.width / 2 {
                viewModel.goToNext()
                viewModel.markCurrentAsSeen()
            } else {
                viewModel.goToPrevious()
                viewModel.markCurrentAsSeen()
            }
        }
        
    }
}

#Preview {
    StoryPreviewView(viewModel: StoryPreviewViewModel(storyEntry: UserStoryEntry(user: User(id: 0, photoURLString:  "https://i.pravatar.cc/300?u=9" , name: "Alex Jones"), stories: [StoryData(id: "1", image_url: URL(string: "https://picsum.photos/id/19/2500/1667")! , timestamp: Date()), StoryData(id: "1", image_url: URL(string: "https://picsum.photos/id/21/3008/2008")! , timestamp: Date())]), feedViewModel: StoriesFeedViewModel(context: DataController.previewContext)))
}
