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
    
    @ObjectBinding var player: Player
    
    init(player: Player = Container.player) {
        self.player = player
    }
    
    var body: some View {
        return VStack {
            if player.hasEpisodes {
                ProgressView(progress: player.progress)
                HStack {
                    Button(action: {
                        self.player.previous()
                    }) {
                        return Image(systemName: "backward.end")
                    }.imageScale(.large)
                    Button(action: {
                        switch self.player.state {
                        case .empty, .finish:
                            break
                        case .idle:
                            self.player.play()
                        case .playing:
                            self.player.pause()
                        case .paused:
                            self.player.play()
                        }
                    }) { () -> Image in
                        switch self.player.state {
                        case .empty, .paused, .idle:
                            return Image(systemName: "play")
                        case .playing:
                            return Image(systemName: "pause")
                        case .finish:
                            return Image(systemName: "pause")
                        }
                    }.imageScale(.large)
                    Button(action: {
                        self.player.next()
                    }) {
                        return Image(systemName: "forward.end")
                    }.imageScale(.large)
                    Text(player.current?.title)
                    Spacer()
                }.padding()
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
