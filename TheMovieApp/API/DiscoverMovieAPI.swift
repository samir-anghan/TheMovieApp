//
//  DiscoverMovieAPI.swift
//  TheMovieApp
//
//  Created by Samir  on 10/17/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//

import Foundation
import Moya

enum DiscoverMovieAPI {
    case movies(page:Int)
}

extension DiscoverMovieAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/") else { fatalError("baseURL could not be configured") }
        return url
    }
    
    var path: String {
        return "movie"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .movies(let page):
            return ["api_key": API.apiKey, "page": page]
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
