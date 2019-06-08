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
        NavigationView() {
            List(podcastViewModel.podcasts.identified(by: \.id)) { podcast in
                NavigationButton(destination: PodcastView(podcast: podcast), label: { PodcastRow(podcast: podcast) })
                }.onAppear(perform: {
                    self.podcastViewModel.bestPodcasts()
                })
            .navigationBarTitle(Text("Best Podcasts"))
        }
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        PodcastsView()
    }
}
#endif
