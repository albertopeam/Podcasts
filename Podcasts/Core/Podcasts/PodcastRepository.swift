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
    
    var bestPodcasts: AnyPublisher<[Podcast], Error> {
        var urlComponents = URLComponents(string: endpoint)!
        urlComponents.path = "/api/v2/best_podcasts"
        urlComponents.queryItems = [URLQueryItem(name: "page", value: "0"),
                                    URLQueryItem(name: "region", value: "us"),
                                    URLQueryItem(name: "safe_mode", value: "0")]
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apiKey, forHTTPHeaderField: "X-ListenAPI-Key")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return URLSession.shared.send(request: request)
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
