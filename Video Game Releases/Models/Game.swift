//
//  Game.swift
//  Video Game Releases
//
//  Created by George on 06/10/2019.
//  Copyright © 2019 George. All rights reserved.
//

import Foundation

struct Game {
    
    let id: Int
    let name: String
    let storyline: String
    let summary: String
    
    let releaseDate: Date
    let popularity: Double
    let rating: Double
    let coverURLString: String
    let screenshotURLsString: [String]
    let genres: [String]
    let company: String
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        return formatter
    }()
    
    
    var releaseDateText: String {
        return Game.dateFormatter.string(from: releaseDate)
    }
    
    var coverURL: URL? {
        return URL(string: coverURLString)
    }
    
    var genreText: String {
        return genres.joined(separator: ", ")
    }
    
    var screenshootURLs: [URL] {
        return screenshotURLsString.compactMap { URL(string: $0) }
    }
    
}


extension Game: Identifiable {}
