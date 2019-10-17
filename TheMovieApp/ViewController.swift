//
//  ViewController.swift
//  TheMovieApp
//
//  Created by Samir on 10/16/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.getMovies(page: 1) { movies in
            print(movies)
        }
    }


}

