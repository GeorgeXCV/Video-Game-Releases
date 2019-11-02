//
//  GameRootView.swift
//  Video Game Releases
//
//  Created by George on 08/10/2019.
//  Copyright © 2019 George. All rights reserved.
//

import SwiftUI

struct GameRootView: View {
    
    var body: some View {
        TabView {
            ForEach(Platform.allCases, id: \.self) { p in
                GameListView(platform: p).tag(p)
                    .tabItem {
                        Image(p.assetName)
                        Text(p.description)
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct GameRootView_Previews: PreviewProvider {
    static var previews: some View {
        GameRootView()
    }
}

