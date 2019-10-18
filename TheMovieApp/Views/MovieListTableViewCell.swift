//
//  MovieListTableViewCell.swift
//  TheMovieApp
//
//  Created by Samir on 10/17/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyStarRatingView

class MovieListTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "MovieListTableViewCellIdentifier"
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var starRatingView: SwiftyStarRatingView!
    
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(movie: Movie) {
        
        self.titleLabel.text = movie.title
        self.overviewLabel.text = movie.overview
        
         guard let moviePosterUrl = URL(string: "http://image.tmdb.org/t/p/w500\(movie.posterPath)") else { return }
        
        let resource = ImageResource(downloadURL: moviePosterUrl, cacheKey: movie.title)
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(with: resource)
        
        starRatingView.value = CGFloat(ceil(movie.voteAverage / 2))       
    }
    
}
