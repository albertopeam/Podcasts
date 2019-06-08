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
    private(set) var podcasts = [Podcast]() {
        didSet { didChange.send(self) }
    }
    
    init(podcastRepository: PodcastRepository = PodcastRepository()) {
        self.podcastRepository = podcastRepository
    }
    
    deinit {
        //TODO: cancelable???
        podcastsCancelable?.cancel()
    }
    
    func bestPodcasts() {
        podcastsCancelable = podcastRepository
            .bestPodcasts
            .map({ (podcasts) -> [Podcast] in return podcasts.sorted(by: { $0.title < $1.title }) })
            .replaceError(with: [])
            .assign(to: \.podcasts, on: self)
    }
    
}
