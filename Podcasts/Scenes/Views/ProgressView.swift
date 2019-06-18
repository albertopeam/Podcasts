//
//  ProgressView.swift
//  Podcasts
//
//  Created by Alberto on 18/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import SwiftUI

final class ProgressView: UIViewRepresentable {
    
    typealias UIViewType = UIProgressView
    private let progress: Float
    
    init(progress: Float = 0) {
        self.progress = progress
    }
    
    func makeUIView(context: UIViewRepresentableContext<ProgressView>) -> UIProgressView {
        let progressView = UIProgressView.init(frame: CGRect.zero)
        progressView.progress = progress
        return progressView
    }
    
    func updateUIView(_ uiView: UIProgressView, context: UIViewRepresentableContext<ProgressView>) {
        uiView.setProgress(progress, animated: true)
    }
    
}
