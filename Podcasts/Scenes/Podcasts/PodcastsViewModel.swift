//
//  Podcasts.swift
//  Podcasts
//
//  Created by Alberto on 07/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class PodcastsViewModel: BindableObject {
    
    var didChange = PassthroughSubject<PodcastsViewModel, Never>()
    private let podcastRepository: PodcastRepository
    private var podcastsCancelable: Cancellable?
    private var page: Int
    //TODO: enum state
    private(set) var podcasts = [Podcast]() { didSet { didChange.send(self) } }
    
    init(podcastRepository: PodcastRepository = PodcastRepository(),
         page: Int = 0) {
        self.podcastRepository = podcastRepository
        self.page = page
    }
    
    deinit {
        podcastsCancelable?.cancel()
    }
    
    func bestPodcasts() {
        podcastsCancelable = podcastRepository
            .bestPodcasts(page: page)
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .sink(receiveValue: { self.podcasts.append(contentsOf: $0) })
        page += 1
    }
    
}
