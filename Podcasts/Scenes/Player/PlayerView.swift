//
//  PlayerView.swift
//  Podcasts
//
//  Created by Alberto on 11/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import SwiftUI
import Combine

struct PlayerView : View {
    
    //TODO: @EnvironmentObject ??? y dejar que se autoinyecte???
    //TODO: only injecting one Episode... use all to play...
    @ObjectBinding var player: Player
    let episodes: [Episode]
    
    init(episodes: [Episode], player: Player = Player()) {
        self.episodes = episodes
        self.player = player
    }
    
    var body: some View {
        HStack {
            Button(action: {
                switch self.player.state {
                case .empty:
                    self.player.setup(for: self.episodes)
                    self.player.play()
                case .playing(let episode, let progress):
                    self.player.pause()
                case .paused(let episode, let progress):
                    self.player.play()
                case .finish(let episodes):
                    break
                }
            }) { () -> Image in
                switch self.player.state {
                case .empty, .paused:
                    return Image(systemName: "play")//.imageScale(.large)
                case .playing(let episode, let progress):
                    return Image(systemName: "pause")//.imageScale(.large)
                case .finish(let episodes):
                    return Image(systemName: "pause")//.imageScale(.large)
                }
            }
        }
    }
    
}

#if DEBUG
struct PlayerView_Previews : PreviewProvider {
    static var previews: some View {
        PlayerView(episodes: episodes)
    }
}
#endif
