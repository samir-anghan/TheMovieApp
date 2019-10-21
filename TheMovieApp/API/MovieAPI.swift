//
//  DiscoverMovieAPI.swift
//  TheMovieApp
//
//  Created by Samir  on 10/17/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//

import Foundation
import Moya

enum MovieAPI {
    case discover(page:Int)
    case search(query: String)
}

extension MovieAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/") else { fatalError("baseURL could not be configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .discover:
            return "discover/movie"
        case .search:
            return "search/movie"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .discover, .search:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .discover(let page):
            return ["api_key": API.apiKey, "page": page]
        case .search(let query):
            return ["api_key": API.apiKey, "query": query]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.queryString
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
    }
    
    var headers: [String : String]? {
        return nil
    }
}
