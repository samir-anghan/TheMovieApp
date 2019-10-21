//
//  RealmService.swift
//  TheMovieApp
//
//  Created by Samir on 10/19/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//

import Foundation
import RealmSwift

class StorageManager {
    private init() {}
    static let shared = StorageManager()
    
    internal var realm: Realm {
        do {
            return try Realm()
        }
        catch let e {
            print("Error while reading from Realm: \(e.localizedDescription) Realm DB will be deleted.")
            do {
                try FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
            }
            catch let e {
                print("Error while trying to delete Realm DB: \(e.localizedDescription)")
            }
        }
        
        do {
            return try Realm()
        }
        catch let e {
            print("Error after Realm was deleted: \(e.localizedDescription)")
            fatalError()
        }
    }
    
    var documentsUrl: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first ?? nil
    }
    
    func add<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch let e {
            print("Error while adding realm object: \(e.localizedDescription)")
        }
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch let e {
            print("Error while deleting realm object: \(e.localizedDescription)")
        }
    }
    
    func removeFromFavouriteMovies(movie: Movie) {
        let predicate = NSPredicate(format: "id == %d", movie.id)
        if let movieToDelete = realm.objects(FavouriteMovie.self)
            .filter(predicate).first {
            delete(movieToDelete)
        }
    }
    
    func getFavouriteMovies() -> Results<FavouriteMovie> {
        realm.objects(FavouriteMovie.self)
    }
    
    func getMovieReview(movieId: Int) -> Review? {
        let predicate = NSPredicate(format: "id == %d", movieId)
        return realm.objects(Review.self)
            .filter(predicate).first
    }
}
