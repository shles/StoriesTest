//
//  HomeFeedView.swift
//  StoriesApp
//
//  Created by Artemis Shlesberg on 11/4/25.
//

import SwiftUI

struct HomeFeedView: View {
    var body: some View {
        ScrollView {
            VStack {
                StoriesFeedView()
                PostsFeedView()
                    .opacity(0.3)
            }
        }
    }
}

#Preview {
    HomeFeedView()
}
