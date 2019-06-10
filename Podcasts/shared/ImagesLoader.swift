//
//  KingfisherWrapper.swift
//  Podcasts
//
//  Created by Alberto on 10/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import UIKit.UIImage
import SwiftUI
import Combine
import class Kingfisher.ImageDownloader

class ImagesLoader: BindableObject {
    
    var didChange = PassthroughSubject<ImagesLoader, Never>()
    private(set) var images = [URL: UIImage]() {
        didSet {
            didChange.send(self)
        }
    }
    private let downloader: ImageDownloader
    
    init(downloader: ImageDownloader = ImageDownloader.default) {
        self.downloader = downloader
    }

    func load(url: URL?) {
        guard let url = url else {
            return
        }
        downloader.downloadImage(with: url, options: nil, progressBlock: nil) { (result) in
            switch result {
            case .success(let image):
                self.images[url] = image.image
            case .failure(_):
                break
            }
        }
    }
    
    func image(for url: URL?) -> UIImage {
        guard let url = url else {
            return UIImage.from(color: .gray)
        }
        guard let image = images[url] else {
            return UIImage.from(color: .gray)
        }
        return image
    }
    
}
