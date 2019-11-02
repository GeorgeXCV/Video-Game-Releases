//
//  GameListView.swift
//  Video Game Releases
//
//  Created by George on 06/10/2019.
//  Copyright © 2019 George. All rights reserved.
//

import SwiftUI

 struct GameListView: View {
    
    @ObservedObject var gameList: GameList = GameList()
       var platform: Platform = .ps4
       
       var body: some View {
           NavigationView {
                   Group {
                       if gameList.isLoading {
                           LoadingView()
                       } else {
                           List(self.gameList.games) { (game: Game) in
                               NavigationLink(destination: GameDetailView(gameId: game.id)) {
                                   GameRowView(game: game)
                               }
                           }
                       }
                   }
                   .navigationBarTitle(Text(self.platform.description), displayMode: .large)
               }
               .onAppear {
                   if self.gameList.games.isEmpty {
                       self.gameList.reload(platform: self.platform)
                   }
           }
        }
    }

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView()
    }
}
