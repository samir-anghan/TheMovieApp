//
//  APIResults.swift
//  TheMovieApp
//
//  Created by Samir on 10/17/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//

import Foundation

struct APIResults: Decodable {
    let page: Int
    let resultsCount: Int
    let pagesCount: Int
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case page
        case resultsCount = "total_results"
        case pagesCount = "total_pages"
        case movies = "results"
    }
}
