//
//  PodcastRow.swift
//  Podcasts
//
//  Created by Alberto on 08/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import SwiftUI

struct PodcastRow : View {
    
    @ObjectBinding var imageLoader: KingfisherWrapper
    let podcast: Podcast
    
    init(imageLoader: KingfisherWrapper = KingfisherWrapper.shared,
         podcast: Podcast) {
        self.imageLoader = imageLoader
        self.podcast = podcast
    }
    
    var body: some View {
        HStack {
            Image(uiImage: self.imageLoader.image(for: self.podcast.thumbnail))
                .frame(width: 64, height: 64, alignment: .center)
                .aspectRatio(contentMode: ContentMode.fit)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(podcast.title)
                    .lineLimit(nil)
                    .font(.headline)
                Text(podcast.language)
                    .lineLimit(1)
                    .font(.caption)
            }
        }.onAppear {
            self.imageLoader.load(url: self.podcast.thumbnail)
        }
    }
}

#if DEBUG
struct PodcastRow_Previews : PreviewProvider {
    static var previews: some View {
        PodcastRow(podcast: podcasts.first!)
    }
}
#endif
