//
//  MovieListViewModel.swift
//  TheMovieApp
//
//  Created by Samir on 10/17/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//

import Foundation

protocol MovieListViewModelDelegate: class {
    func loading()
    func dataReady()
}

class MovieListViewModel {
    
    var dataSource = [Movie]()
    weak var delegate: MovieListViewModelDelegate?
    
    func fetchMovies() {
        delegate?.loading()
        API.getMovies(page: 1) { movies in
            self.dataSource = movies
            self.delegate?.dataReady()
        }
    }
}
