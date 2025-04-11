//
//  HomeFeedView.swift
//  StoriesApp
//
//  Created by Artemis Shlesberg on 11/4/25.
//

import SwiftUI

struct HomeFeedView: View {
    @Environment(\.modelContext) private var context
    var body: some View {
        ScrollView {
            VStack {
                StoriesFeedView(viewModel: StoriesFeedViewModel(context: context))
                PostsFeedView()
                    .opacity(0.3)
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    HomeFeedView()
}
