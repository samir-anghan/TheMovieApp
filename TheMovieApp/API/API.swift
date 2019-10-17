//
//  API.swift
//  TheMovieApp
//
//  Created by Samir on 10/17/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//

import Foundation
import Moya

class API {
    
    static let apiKey = "dcc0f5566ff241db4235901f3490e304"
    static let discoverMovieProvider = MoyaProvider<DiscoverMovieAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    static func getMovies(page: Int, completion: @escaping ([Movie])->()) {
        discoverMovieProvider.request(.movies(page: page)) { result in
            switch result {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(APIResults.self, from: response.data)
                    completion(results.movies)
                } catch (let error) {
                    print("Error decoding movies data: \(error)")
                }
            case .failure(let error):
                 print("Network request error: \(error)")
            }
        }
    }
}
