//
//  Episode.swift
//  Podcasts
//
//  Created by Alberto on 09/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import Foundation

struct Episode: Equatable {
    let id: String
    let title: String
    let description: String
    let pubDate: Date
    let audio: URL?
    let audioLenght: Int
    let image: URL?
    let thumbnail: URL?
    let maybeAudioInvalid: Bool
    let explicitContent: Bool
}
