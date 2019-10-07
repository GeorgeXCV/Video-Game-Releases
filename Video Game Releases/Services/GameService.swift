//
//  GameService.swift
//  Video Game Releases
//
//  Created by George on 06/10/2019.
//  Copyright © 2019 George. All rights reserved.
//

import Foundation

protocol GameService {    
    func fetchPopularGames(for platform: Platform, completion: @escaping (Result<[Game], Error>) -> Void)
    func fetchGame(id: Int, completion: @escaping (Result<Game, Error>) -> Void)
}
