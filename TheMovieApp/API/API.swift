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
    static let provider = MoyaProvider<MovieAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    static func getMovies(page: Int, completion: @escaping ([Movie])->()) {
        provider.request(.discover(page: page)) { result in
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
    
    static func searchMovies(query: String, completion: @escaping ([Movie])->()) {
        provider.request(.search(query: query)) { result in
            switch result {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(APIResults.self, from: response.data)
                    completion(results.movies)
                } catch (let error) {
                    print("Error decoding search movies data: \(error)")
                }
            case .failure(let error):
                print("Network request error: \(error)")
            }
        }
    }
}
