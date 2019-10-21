//
//  MovieDetailViewModel.swift
//  TheMovieApp
//
//  Created by Samir on 10/18/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//

import Foundation

class MovieDetailViewModel {
    let movie:  Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func isFavourite() -> Bool {
        let isFavourite = StorageManager.shared.getFavouriteMovies().contains(where: { (favouriteMovie) -> Bool in
            return favouriteMovie.id == movie.id
        })
        return isFavourite
    }
    
    func hasReview() -> Bool {
        return StorageManager.shared.getMovieReview(movieId: movie.id) != nil
    }
}
