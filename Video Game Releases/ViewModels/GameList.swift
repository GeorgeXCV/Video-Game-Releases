//
//  GameList.swift
//  Video Game Releases
//
//  Created by George on 07/10/2019.
//  Copyright © 2019 George. All rights reserved.
//

import Foundation


class GameList: ObservableObject {
    
    @Published var games: [Game] = [] // List of games we will retrieve via API
    @Published var isLoading = false // Show loading indicator if true
    
    var gameService = GameStore.shared // used to retrieve the game list from IGDB API.
    
    func reload(platform: Platform = .ps4) {
        self.games = []
        self.isLoading = true
        
        gameService.fetchPopularGames(for: platform) { [weak self]  (result) in
            self?.isLoading = false
            
            switch result {
            case .success(let games): // If success, retrieve the associated value containing the games and assign it the games instance property.
                self?.games = games
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
