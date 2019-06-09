//
//  PodcastView.swift
//  Podcasts
//
//  Created by Alberto on 08/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import SwiftUI

struct PodcastView : View {
    
    @ObjectBinding var podcastViewModel: PodcastViewModel
    
    init(podcast: Podcast) {
        self.podcastViewModel = PodcastViewModel(podcast: podcast)
    }
    
    var body: some View {
        VStack {
            Text(podcastViewModel.podcast.title)
                .lineLimit(2)
                .font(.headline)
            List(podcastViewModel.episodes.identified(by: \.id)){ episode in
                NavigationButton(destination: EpisodeView()) {
                    Text(episode.title)
                }
            }
        }.onAppear(perform: {
            self.podcastViewModel.loadEpisodes()
        })
    }
}

#if DEBUG
struct PodcastView_Previews : PreviewProvider {
    static var previews: some View {
        PodcastView(podcast: podcasts.first!)
    }
}
#endif
