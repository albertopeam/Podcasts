//
//  EpisodeView.swift
//  Podcasts
//
//  Created by Alberto on 09/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import SwiftUI

struct EpisodeView : View {
    
    let episode: Episode
    
    var body: some View {
        Text(episode.title).font(.headline).color(.red).navigationBarTitle(Text(episode.title))
    }
}

#if DEBUG
struct EpisodeView_Previews : PreviewProvider {
    static var previews: some View {
        EpisodeView(episode: episodes.first!)
    }
}
#endif
