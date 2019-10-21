//
//  MovieListViewModel.swift
//  TheMovieApp
//
//  Created by Samir on 10/17/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//

import Foundation
import Alamofire

protocol MovieListViewModelDelegate: class {
    func loading()
    func dataReady()
}

class MovieListViewModel {
    
    var dataSource = [Movie]()
    var searchResults = [Movie]()
    lazy var dataToDisplay = [Movie]()
    
    weak var delegate: MovieListViewModelDelegate?
    
    private var searchTerms = ""
    private var previousTerms: String?
    private let debouncer = Debouncer(timeInterval: 0.5)
    
    func fetchMovies() {
        delegate?.loading()
        API.getMovies(page: 1) { movies in
            self.dataSource = movies
            self.dataToDisplay = self.dataSource
            self.delegate?.dataReady()
        }
    }
    
    func search(terms: String, debounced: Bool = true) {
        searchTerms = terms
        if debounced {
            debouncer.handler = { [weak self] in
                self?.searchRequest()
            }
            debouncer.renewInterval()
        } else {
            self.searchRequest()
        }
    }
    
    private func searchRequest() {
        if previousTerms != searchTerms {
            reset()
            previousTerms = searchTerms
        }
        API.searchMovies(query: searchTerms) { movies in
            self.searchResults = movies
            self.dataToDisplay = self.searchResults
            self.delegate?.dataReady()
        }
    }
    
    private func reset() {
        searchResults = []
    }
}
