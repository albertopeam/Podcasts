//
//  Container.swift
//  Podcasts
//
//  Created by Alberto on 17/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import Foundation

class Container {
    private let player: Player = Player()
}

extension Container {
    private static var instance: Container {
        return AppDelegate.container
    }
    static var player: Player {
        return Container.instance.player
    }
}
