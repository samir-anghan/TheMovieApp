//
//  ReviewViewModel.swift
//  TheMovieApp
//
//  Created by Samir on 10/21/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class ReviewMovieViewModel {
    
    let movie:  Movie
    
    var rating: CGFloat?
    var title: String?
    var review: String?
    var uploadedPhotoUrl: String?
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func addReview(rating: CGFloat?, title: String?, review: String?, uploadedPhotoUrl: String?, _ completion: @escaping () -> Void) {
        let review = Review(id: movie.id, rating: rating ?? 0, title: title ?? "", review: review ?? "", imageUrl: uploadedPhotoUrl ?? "")
        StorageManager.shared.add(review)
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        completion()
    }
}
