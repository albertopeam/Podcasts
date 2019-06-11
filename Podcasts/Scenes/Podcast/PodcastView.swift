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
    @ObjectBinding var imageLoader: ImageLoader
    
    //TODO: como gestionar esta inyeccion????, con un var tal vez????
    init(podcast: Podcast, imageLoader: ImageLoader = ImageLoader()) {
        self.podcastViewModel = PodcastViewModel(podcast: podcast)
        self.imageLoader = imageLoader
    }
    
    var body: some View {
        List {
            PodcastHeaderView(podcast: podcastViewModel.podcast, imageLoader: imageLoader)
            if podcastViewModel.episodes.isEmpty {
                Spinner()
            } else {
                ForEach(podcastViewModel.episodes.identified(by: \.id)) { episode in
                    NavigationButton(destination: EpisodeView(episode: episode)) {
                        EpisodeRow(episode: episode)
                    }
                }
            }
            }
            .navigationBarTitle(Text(podcastViewModel.podcast.title))
            .onAppear(perform: {
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
