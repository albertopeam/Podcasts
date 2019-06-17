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
    //TODO: only one player!!!! shared
    @ObjectBinding var player: Player
    
    init(player: Player = Player()) {
        self.player = player
    }
    
    var body: some View {
        return HStack {
            if player.hasEpisodes {
                Button(action: {
                    switch self.player.state {
                    case .empty, .idle:
                        break
                    case .playing(let episode, let progress):
                        self.player.pause()
                    case .paused(let episode, let progress):
                        self.player.play()
                    case .finish(let episodes):
                        break
                    }
                }) { () -> Image in
                    switch self.player.state {
                    case .empty, .paused, .idle:
                        return Image(systemName: "play")//.imageScale(.large)
                    case .playing(let episode, let progress):
                        return Image(systemName: "pause")//.imageScale(.large)
                    case .finish(let episodes):
                        return Image(systemName: "pause")//.imageScale(.large)
                    }
                }
                Text(player.current?.title)
            }
        }
    }
    
}

extension Text {
    init(_ string: String?) {
        self.init(verbatim: string ?? "")
    }
}
#if DEBUG
struct PlayerView_Previews : PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
#endif
