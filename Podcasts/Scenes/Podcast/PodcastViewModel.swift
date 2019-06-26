//
//  PodcastViewModel.swift
//  Podcasts
//
//  Created by Alberto on 09/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class PodcastViewModel: BindableObject {
    
    var didChange = PassthroughSubject<PodcastViewModel, Never>()
    private let podcastRepository: PodcastRepository
    private var episodesCancelable: Cancellable?
    private(set) var podcast: Podcast {
        didSet { didChange.send(self) }
    }
    private(set) var episodes = [Episode]() {
        didSet { didChange.send(self) }
    }
    
    init(podcast: Podcast,
         podcastRepository: PodcastRepository = PodcastRepository()) {
        self.podcast = podcast
        self.podcastRepository = podcastRepository
    }
    
    deinit {
        episodesCancelable?.cancel()
    }

    func loadEpisodes() {
        episodesCancelable = podcastRepository.episodes(for: podcast)
            .receive(on: RunLoop.main)
            .replaceError(with: [])
            .assign(to: \.episodes, on: self)
    }
    
}
