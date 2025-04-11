//
//  PostsFeedView.swift
//  StoriesApp
//
//  Created by Artemis Shlesberg on 11/4/25.
//

import SwiftUI

struct PostsFeedView: View {
    var body: some View {
        VStack(spacing: 30) {
            ForEach((0...5), id: \.self) { id in
                self.post
                    .id(id)
            }
        }
    }
    
    @ViewBuilder
    var post: some View {
        ZStack(alignment: .top) {
            Rectangle().fill(Color.gray)
                .frame(height: 500)
            HStack {
                Circle().fill(Color.black)
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text("Artemis Shlesberg")
                        .font(.headline)
                    Text("@artemis_shlesberg")
                        .font(.caption)
                }
                .foregroundStyle(Color.white)
                Spacer()
            }
            .padding()
        }
    }
    
}

#Preview {
    PostsFeedView()
}
