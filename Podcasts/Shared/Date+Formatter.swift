//
//  Date+Formatter.swift
//  Podcasts
//
//  Created by Alberto on 11/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import Foundation

extension Date {
    
    var formatMedium: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
    
}

