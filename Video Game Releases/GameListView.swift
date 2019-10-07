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
    
   var body: some View {
        NavigationView {
          Group {
            if gameList.isLoading { // Check if the gameList isLoading is set to true
              Text("Loading") // Then we simply display a Text with loading as the message
            } else { // Otherwise, we initialize List passing the games array from the gameList
              List(gameList.games) { game in //
                Text(game.name)
              }
            }
          }
        }.onAppear {
          self.gameList.reload()
        }
      }
    }
