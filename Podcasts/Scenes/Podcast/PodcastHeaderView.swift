//
//  PodcastHeaderView.swift
//  Podcasts
//
//  Created by Alberto on 10/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import SwiftUI

struct PodcastHeaderView : View {
    
    let podcast: Podcast
    let imageLoader: ImageLoader
    
    init(podcast: Podcast,
         imageLoader: ImageLoader) {
        self.podcast = podcast
        self.imageLoader = imageLoader
    }
    
    var body: some View {
        HStack {
            VStack {
                Image(uiImage: imageLoader.image(for: podcast.thumbnail))
                    .frame(width: 128, height: 128)
                    .aspectRatio(contentMode: ContentMode.fit)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 4)
                Text(podcast.language)
                    .frame(alignment: .trailing)
                    .lineLimit(1)
                    .font(.caption)
                    .foregroundColor(Color.red)
            }
            Spacer().frame(maxWidth: 20)
            VStack(alignment: .leading) {
                Text(podcast.title)
                    .lineLimit(nil)
                    .font(.headline)
                Spacer().frame(maxHeight: 10)
                Text(podcast.description)
                    .lineLimit(nil)
                    .font(.caption)
            }
            }
            .padding([.top])
            .onAppear {
                self.imageLoader.load(url: self.podcast.thumbnail)
        }
    }
    
}

#if DEBUG
struct PodcastHeaderView_Previews : PreviewProvider {
    static var previews: some View {
        PodcastHeaderView(podcast: podcasts.first!, imageLoader: ImageLoader())
    }
}
#endif
