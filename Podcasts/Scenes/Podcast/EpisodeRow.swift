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
        Text(episode.title)
            .font(.headline)
            .lineLimit(nil)
    }
    
}

#if DEBUG
struct EpisodeRow_Previews : PreviewProvider {
    static var previews: some View {
        EpisodeRow(episode: episodes.first!)
    }
}
#endif
