//
//  StoriesFeedView.swift
//  StoriesApp
//
//  Created by Artemis Shlesberg on 11/4/25.
//

import SwiftUI

struct StoriesFeedView: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach((0...20), id: \.self) { index in
                    Circle()
                        .frame(width:100, height: 100)
                }
            }
            .frame(height: 100)
            .padding()
            .scrollIndicators(.never) //TODO: remove
        }
        
    }
}

#Preview {
    StoriesFeedView()
}
