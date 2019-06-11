//
//  EpisodeRow.swift
//  Podcasts
//
//  Created by Alberto on 09/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import SwiftUI

struct EpisodeRow : View {
    
    let episode: Episode
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(episode.title)
                .font(.title)
                .lineLimit(2)
            Text(episode.pubDate.formatMedium)
                .font(.caption)
        }
    }
    
}

#if DEBUG
struct EpisodeRow_Previews : PreviewProvider {
    static var previews: some View {
        EpisodeRow(episode: episodes.first!)
    }
}
#endif
