//
//  ContentView.swift
//  Podcasts
//
//  Created by Alberto on 07/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import SwiftUI

struct PodcastsView : View {
    
    @ObjectBinding var podcastViewModel = PodcastsViewModel()
    
    var body: some View {
        List(podcastViewModel.podcasts.identified(by: \.id)) { podcast in
            Text(podcast.title)
        }.onAppear(perform: {
            self.podcastViewModel.bestPodcasts()
        })
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        PodcastsView()
    }
}
#endif
