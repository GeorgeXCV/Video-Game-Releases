//
//  GameStore.swift
//  Video Game Releases
//
//  Created by George on 07/10/2019.
//  Copyright © 2019 George. All rights reserved.
//


import Foundation
import IGDB_SWIFT_API

class GameStore: GameService {
    
    static let shared = GameStore()
    
    private init() {}
    
    lazy var iGDB: IGDBWrapper = {
        $0.userKey = "3a50469c7071abaa5584110256e0fc86"
        return $0
    }(IGDBWrapper())
    
    // 1570653467
    let date = String(Date().millisecondsSince1970)
    
    func fetchPopularGames(for platform: Platform, completion: @escaping (Result<[Game], Error>) -> Void) {
        iGDB.apiRequest(endpoint: .GAMES, apicalypseQuery: "fields name, first_release_date, id, popularity, rating, involved_companies.company.name, cover.image_id; where (platforms = (\(platform.rawValue)) & first_release_date > \(date.subString(from:0,to:9))) & popularity >= 5 & version_parent = null; sort first_release_date asc; limit: 50;", dataResponse: { bytes in
            guard let gameResults = try? Proto_GameResult(serializedData: bytes) else {
                return
            }
            let games = gameResults.games.map { Game(game: $0) }
            DispatchQueue.main.async {
              completion(.success(games))
            }
        }, errorResponse: { error in
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        })
    }
    
    func fetchGame(id: Int, completion: @escaping (Result<Game, Error>) -> Void) {
        iGDB.apiRequest(endpoint: .GAMES, apicalypseQuery: "fields name, summary, genres.name, storyline, first_release_date, screenshots.image_id, id, popularity, rating, cover.image_id, involved_companies.company.name; where id = \(id);", dataResponse: { (bytes) -> (Void) in
            guard let protoGame = try? Proto_GameResult(serializedData: bytes).games.first else {
                return
            }
            DispatchQueue.main.async {
                completion(.success(Game(game: protoGame, coverSize: .COVER_BIG)))
            }
        }) { error  in
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }
}


fileprivate extension Game {
    
    init(game: Proto_Game, coverSize: ImageSize = .COVER_BIG) {
        let coverURL = imageBuilder(imageID: game.cover.imageID, size: coverSize, imageType: .PNG)
        
        let screenshotURLs = game.screenshots.map { (scr) -> String in
            let url = imageBuilder(imageID: scr.imageID, size: .SCREENSHOT_MEDIUM, imageType: .JPEG)
            return url
        }
        
        let company = game.involvedCompanies.first?.company.name ?? ""
        let genres = game.genres.map { $0.name }
        self.init(id: Int(game.id),
                  name: game.name,
                  storyline: game.storyline,
                  summary: game.summary,
                  releaseDate: game.firstReleaseDate.date,
                  popularity: game.popularity,
                  rating: game.rating,
                  coverURLString: coverURL, screenshotURLsString: screenshotURLs, genres: genres, company: company)
        
    }
    
}


extension Date {
    
    var millisecondsSince1970: Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}

extension String {
    func subString(from: Int, to: Int) -> String {
       let startIndex = self.index(self.startIndex, offsetBy: from)
       let endIndex = self.index(self.startIndex, offsetBy: to)
       return String(self[startIndex...endIndex])
    }
}
