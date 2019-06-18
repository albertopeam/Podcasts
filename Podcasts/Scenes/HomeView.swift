//
//  HomeView.swift
//  Podcasts
//
//  Created by Alberto on 08/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import SwiftUI

struct HomeView : View {
    
    @State private var selected = 0
    
    var body: some View {
        TabbedView(selection: $selected) {
            PodcastsView()
                .tabItemLabel(Text("Podcasts"))
                .tag(0)
//            Text("...")
//                .font(.title)
//                .tabItemLabel(Text("Search"))
//                .tag(1)
        }
    }
}

#if DEBUG
struct HomeView_Previews : PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
#endif
