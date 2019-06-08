//
//  PodcastRow.swift
//  Podcasts
//
//  Created by Alberto on 08/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import SwiftUI

struct PodcastRow : View {
    let podcast: Podcast
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(podcast.title)
                .lineLimit(2)
                .font(.headline)
            Text(podcast.language).lineLimit(1)
                .font(.caption)
        }.padding()
    }
}

#if DEBUG
struct PodcastRow_Previews : PreviewProvider {
    static var previews: some View {
        PodcastRow(podcast: podcasts.first!)
    }
}
#endif
