//
//  Movie.swift
//  TheMovieApp
//
//  Created by Samir on 10/16/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//

import Foundation
import RealmSwift

struct Movie: Decodable {
    let id: Int!
    let popularity: Double
    let totalVotes: Int
    let hasVideo: Bool
    let posterPath: String?
    let isAdult: Bool
    let language: String
    let title: String
    let voteAverage: Double
    let overview: String
    let releaseDate: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, popularity, title, overview
        case totalVotes = "vote_count"
        case hasVideo = "video"
        case posterPath = "poster_path"
        case isAdult = "adult"
        case language = "original_language"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
}

class FavouriteMovie: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(movie: Movie) {
        self.init()
        
        id = movie.id
        title = movie.title
    }
}
