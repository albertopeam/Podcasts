//
//  PodcastRepository.swift
//  Podcasts
//
//  Created by Alberto on 07/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class PodcastRepository {
    
    private let apiKey: String = "451c455ef9164578b7c627fd99e1ee9b"
    private let endpoint: String = "https://listen-api.listennotes.com"
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    private var components: URLComponents {
        return URLComponents(string: endpoint)!
    }
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    var bestPodcasts: AnyPublisher<[Podcast], Error> {
        var urlComponents = components
        urlComponents.path = "/api/v2/best_podcasts"
        urlComponents.queryItems = [URLQueryItem(name: "page", value: "0"),
                                    URLQueryItem(name: "region", value: "us"),
                                    URLQueryItem(name: "safe_mode", value: "0")]
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apiKey, forHTTPHeaderField: "X-ListenAPI-Key")
        return urlSession.send(request: request)
            .decode(type: CodableBestPodcasts.self, decoder: decoder)
            .map { $0.podcasts }
            .map({ $0.map({ Podcast(id: $0.id,
                                    title: $0.title,
                                    image: URL(string: $0.image),
                                    thumbnail: URL(string: $0.thumbnail),
                                    totalEpisodes: $0.totalEpisodes,
                                    explicitContent: $0.explicitContent,
                                    description: $0.description,
                                    language: $0.language,
                                    country: $0.country,
                                    rss: URL(string: $0.rss),
                                    latestPubDateMs: Date(timeIntervalSince1970: TimeInterval($0.latestPubDateMs)),
                                    earliestPubDateMs: Date(timeIntervalSince1970: TimeInterval($0.earliestPubDateMs)))}) })
            .print()
            .share()
            .eraseToAnyPublisher()
    }
    
    func episodes(for podcast: Podcast) -> AnyPublisher<[Episode] ,Error> {
        var urlComponents = components
        urlComponents.path = "/api/v2/podcasts/\(podcast.id)"
        urlComponents.queryItems = [URLQueryItem(name: "sort", value: "recent_first")]
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apiKey, forHTTPHeaderField: "X-ListenAPI-Key")
        return urlSession.send(request: request)
            .decode(type: CodableEpisodes.self, decoder: decoder)
            .map { $0.episodes }
            .map({ $0.map({ Episode(id: $0.id,
                                    title: $0.title,
                                    description: $0.description,
                                    pubDate: Date(timeIntervalSince1970: TimeInterval($0.pubDateMs)),
                                    audio: URL(string: $0.audio),
                                    audioLenght: $0.audioLengthSec,
                                    image: URL(string: $0.image),
                                    thumbnail: URL(string: $0.thumbnail),
                                    maybeAudioInvalid: $0.maybeAudioInvalid,
                                    explicitContent: $0.explicitContent)}) })
            .print()
            .share()
            .eraseToAnyPublisher()
    }
    
}

private struct CodableBestPodcasts: Codable {
    let podcasts: [CodablePodcast]
}

private struct CodablePodcast: Codable {
    let id: String
    let title: String
    let image: String
    let thumbnail: String
    let totalEpisodes: Int
    let explicitContent: Bool
    let description: String
    let language: String
    let country: String
    let rss: String
    let latestPubDateMs: Int
    let earliestPubDateMs: Int
}

private struct CodableEpisodes: Codable {
    let episodes: [CodableEpisode]
    let nextEpisodePubDate: Int
}

private struct CodableEpisode: Codable {
    let id: String
    let title: String
    let description: String
    let pubDateMs: Int
    let audio: String
    let audioLengthSec: Int
    let image: String
    let thumbnail: String
    let maybeAudioInvalid: Bool
    let explicitContent: Bool
}

