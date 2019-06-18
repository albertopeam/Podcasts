//
//  AppDelegate+Container.swift
//  Podcasts
//
//  Created by Alberto on 17/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import UIKit.UIApplication

extension AppDelegate {
    static var container: Container {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.appContainer
    }
}
