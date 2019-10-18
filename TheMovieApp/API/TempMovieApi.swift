//
//  MovieAPI.swift
//  TheMovieApp
//
//  Created by Samir on 10/17/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//

import Foundation
import Moya

enum TempMovieApi {
    case reco(id:Int)
    case topRated(page:Int)
    case newMovies(page:Int)
    case video(id:Int)
}

extension TempMovieApi: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie/") else { fatalError("baseURL could not be configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .reco(let id):
            return "\(id)/recommendations"
        case .topRated:
            return "popular"
        case .newMovies:
            return "now_playing"
        case .video(let id):
            return "\(id)/videos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .reco, .topRated, .newMovies, .video:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .reco, .video:
            return ["api_key": API.apiKey]
        case .topRated(let page), .newMovies(let page):
            return ["page": page, "api_key": API.apiKey]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .reco, .topRated, .newMovies, .video:
            return URLEncoding.queryString
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .reco, .topRated, .newMovies, .video:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}


