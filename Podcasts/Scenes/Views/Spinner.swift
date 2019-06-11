//
//  Spinner.swift
//  Podcasts
//
//  Created by Alberto on 11/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import SwiftUI

struct Spinner : View {
    
    let items: Int = 3
    
    var body: some View {
        HStack {
            ForEach(0..<items) { (i:Int) in
                Text("•")
                    .animation(Animation.default.repeatForever().delay(Double(i)*0.2))
                    .font(.largeTitle)
            }
        }
    }
    
}

#if DEBUG
struct Spinner_Previews : PreviewProvider {
    static var previews: some View {
        Spinner()
    }
}
#endif
