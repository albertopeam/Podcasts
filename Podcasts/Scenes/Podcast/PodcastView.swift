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
            //TODO: move to header and insert inside list
            HStack {
                VStack {
                    Image("placeholder")
                        .frame(width: 150, height: 150, alignment: .center)
                        .aspectRatio(contentMode: ContentMode.fit)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 4)
                    Text(podcastViewModel.podcast.language)
                        .frame(alignment: .trailing)
                        .lineLimit(1)
                        .font(.caption)
                        .foregroundColor(Color.red)
                }
                VStack {
                    Text(podcastViewModel.podcast.title)
                        .lineLimit(2)
                        .font(.headline)
                    Text(podcastViewModel.podcast.description)
                        .lineLimit(10)
                        .font(.caption)
                }
                Spacer()
            }.padding()
            List(podcastViewModel.episodes.identified(by: \.id)){ episode in
                NavigationButton(destination: EpisodeView()) {
                    //TODO: mover a row
                    //TODO: hacer player
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
