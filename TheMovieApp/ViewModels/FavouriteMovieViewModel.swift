//
//  FavouriteMovieViewModel.swift
//  TheMovieApp
//
//  Created by Samir on 10/20/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//

import Foundation
import RealmSwift

class FavouriteMovieViewModel {
    let favouriteMovies:  Results<FavouriteMovie>
    
    init() {
        favouriteMovies = StorageManager.shared.getFavouriteMovies()
    }
    
    func removeFromFavouriteList(movie: FavouriteMovie) {
        StorageManager.shared.delete(movie)
    }
    
    func hasFavouriteMovies() -> Bool {
        return !favouriteMovies.isEmpty
    }
}
