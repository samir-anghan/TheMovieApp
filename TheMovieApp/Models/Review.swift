//
//  Review.swift
//  TheMovieApp
//
//  Created by Samir on 10/20/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//

import Foundation
import RealmSwift

class Review: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var rating: CGFloat = 0
    @objc dynamic var title: String = ""
    @objc dynamic var review: String = ""
    @objc dynamic var imageUrl: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int, rating: CGFloat, title: String, review: String = "", imageUrl: String = "") {
        self.init()
        
        self.id = id
        self.rating = rating
        self.title = title
        self.review = review
        self.imageUrl = imageUrl
    }
    
}
