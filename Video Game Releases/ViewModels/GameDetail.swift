//
//  GameDetail.swift
//  Video Game Releases
//
//  Created by George on 08/10/2019.
//  Copyright © 2019 George. All rights reserved.
//

import SwiftUI

class GameDetail: ObservableObject {
    
    @Published var game: Game? = nil
    @Published var isLoading = false
    
    var gameService: GameService = GameStore.shared
    
    func reload(id: Int) {
        self.isLoading = true
        
   self.gameService.fetchGame(id: id) {[weak self] (result) in // Pass id of game as parameter. Fetch detail of gamee using GameServicee objeet
                    self?.isLoading = false
                    
                    switch result {
                    case .success(let game):
                        self?.game = game // Assign game property with the game we succesfully feteched from the API
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }

