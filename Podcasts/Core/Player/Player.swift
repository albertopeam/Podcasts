
//
//  Player.swift
//  Podcasts
//
//  Created by Alberto on 11/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import Foundation
import MediaPlayer
import Combine
import SwiftUI

class Player: BindableObject {
    
    enum State {
        case empty
        case idle(episodes: [Episode])
        case playing(episode: Episode, progress: Float)
        case paused(episode: Episode, progress: Float)
        case finish(episodes: [Episode])
    }
    
    var didChange: CurrentValueSubject<State, Never> = CurrentValueSubject(.empty)
    var state: State = .empty {
        didSet {
            didChange.send(state)
        }
    }
    var current: Episode?
    private var episodes: [Episode] = []
    private let avPlayer: AVPlayer
    private let notificationCenter: NotificationCenter
    private let systemPlayer: MPNowPlayingInfoCenter

    init(avPlayer: AVPlayer = AVPlayer(),
         avSession: AVAudioSession = AVAudioSession.sharedInstance(),
         notificationCenter: NotificationCenter = .default,
         systemPlayer: MPNowPlayingInfoCenter = MPNowPlayingInfoCenter.default()) {
        self.avPlayer = avPlayer
        self.notificationCenter = notificationCenter
        self.systemPlayer = systemPlayer
        self.notificationCenter.addObserver(self, selector: #selector(self.didPlayToEnd), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        let interval = CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        self.avPlayer.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: didUpdatedPlayer)
        try? avSession.setCategory(AVAudioSession.Category.playback,
                                   mode: AVAudioSession.Mode.default,
                                   options: [.allowBluetooth, .allowAirPlay, .defaultToSpeaker])
    }
    
    deinit {
        notificationCenter.removeObserver(self)
        avPlayer.removeTimeObserver(self)
    }
    
    // MARK: Player
    
    func setup(for episodes: [Episode]) {
        let newEpisodes = episodes.filter({ $0.audio != nil })
        if let first = newEpisodes.first, let url = first.audio {
            if !isPlayingNow() || episodes != newEpisodes {
                self.episodes = newEpisodes
                current = first                
                avPlayer.replaceCurrentItem(with: AVPlayerItem(url: url))
                state = .idle(episodes: newEpisodes)
                return
            }
        }
    }
    
    var hasEpisodes: Bool {
        return !episodes.isEmpty
    }
    
    func play() {
        guard let episode = current else {
            return
        }
        playNow(next: episode)
    }
    
    func pause() {
        pauseNow()
    }
    
    func previous() {
        guard let previousEpisode = previousEpisode() else {
            self.current = nil
            return
        }
        playNow(next: previousEpisode)
    }
    
    func next() {
        guard let nextEpisode = nextEpisode() else {
            self.current = nil
            return
        }
        self.playNow(next: nextEpisode)
    }
    
    var progress: Float {
        guard let playerDuration = avPlayer.currentItem?.duration else { return 0 }
        let totalTime = Float(CMTimeGetSeconds(playerDuration))
        guard !totalTime.isNaN else { return 0 }
        let currentTime = Float(CMTimeGetSeconds(avPlayer.currentTime()))
        return currentTime / totalTime
    }
    
    // MARK: NotificationCenter
    
    @objc private func didPlayToEnd() {
        guard let next = nextEpisode() else {
            self.current = nil
            state = .finish(episodes: episodes)
            return
        }
        playNow(next: next)
    }
    
    // MARK: Player
    
    @objc private func didUpdatedPlayer(time: CMTime) {
        switch state {
        case .empty, .paused, .finish, .idle:
            return
        case .playing:
            break
        }
        guard let episode = current else { return }
        state = .playing(episode: episode, progress: progress)
    }
    
    // MARK: Private
    
    private func previousEpisode() -> Episode? {
        guard let current = self.current else { return nil }
        guard let curIndex = episodes.firstIndex(of: current) else { return nil }
        let target = curIndex - 1
        guard target >= 0 else { return self.current }
        return episodes[target]
    }

    private func nextEpisode() -> Episode? {
        guard let current = self.current else { return nil }
        guard let curIndex = episodes.firstIndex(of: current) else { return nil }
        let target = curIndex + 1
        guard target < episodes.count else { return nil }
        return episodes[target]
    }
    
    private func playNow(next: Episode) {
        guard let url = next.audio else { return }
        if current != next {
            self.avPlayer.replaceCurrentItem(with: AVPlayerItem(url: url))
        }
        current = next
        avPlayer.play()
        notificationCenter.addObserver(self, selector: #selector(self.didArriveInterruption), name: AVAudioSession.interruptionNotification, object: nil)
        notifySystemPlayer(episode: next)
        state = .playing(episode: next, progress: progress)
    }
    
    private func pauseNow() {
        guard let episode = current else { return }
        self.avPlayer.pause()
        self.notificationCenter.removeObserver(self, name: AVAudioSession.interruptionNotification, object: nil)
        state = .paused(episode: episode, progress: progress)
    }
    
    private func isPlayingNow() -> Bool {
        return avPlayer.rate > 0
    }
    
    private func notifySystemPlayer(episode: Episode) {
        let info: [String: Any] = [
            MPMediaItemPropertyTitle: episode.title,
        ]
        systemPlayer.nowPlayingInfo = info
    }
    
    // MARK: Interruptions
    
    @objc private func didArriveInterruption(notification: NSNotification) {
        if let value = notification.userInfo?[AVAudioSessionInterruptionTypeKey] as? NSNumber,
            let type = AVAudioSession.InterruptionType(rawValue: value.uintValue){
            switch type {
            case .began:
                pause()
            case .ended:
                play()
            @unknown default:
                fatalError()
            }
        }
    }
    
}
