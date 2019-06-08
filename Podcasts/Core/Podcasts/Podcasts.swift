//
//  Podcasts.swift
//  Podcasts
//
//  Created by Alberto on 07/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import Foundation

struct Podcast {
    let id: String
    let title: String
    let image: URL?
    let thumbnail: URL?
    let totalEpisodes: Int
    let explicitContent: Bool
    let description: String
    let language: String
    let country: String
    let rss: URL?
    let latestPubDateMs: Date
    let earliestPubDateMs: Date
}
