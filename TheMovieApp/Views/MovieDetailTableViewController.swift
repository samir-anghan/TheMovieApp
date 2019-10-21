//
//  MovieDetailTableViewController.swift
//  TheMovieApp
//
//  Created by Samir on 10/18/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyStarRatingView
import RealmSwift

class MovieDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var starRatingView: SwiftyStarRatingView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var addToFavouriteButton: UIButton!
    @IBOutlet weak var emptyReviewView: UIView!
    @IBOutlet weak var reviewView: UIView!
    @IBOutlet weak var reviewRating: SwiftyStarRatingView!
    @IBOutlet weak var reviewTitleLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet var detailsTableView: UITableView!
    
    var viewModel: MovieDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsTableView.delegate = self
        guard let vm = viewModel else { return }
        
        let movie = vm.movie
        self.title = movie.title
        overviewLabel.text = movie.overview
        
        let rating = CGFloat(ceil(movie.voteAverage / 2))
        starRatingView.value = rating
        ratingLabel.text = "\(rating)/5"
        votesLabel.text = "(\(movie.totalVotes) votes)"
        releaseDateLabel.text = DateStringFormatter.format(dateString: movie.releaseDate ?? "N/A")
        
        updateUI()
        
        guard let posterPath = movie.posterPath,
            let moviePosterUrl = URL(string: "http://image.tmdb.org/t/p/w500\(posterPath)") else { return }
        
        let resource = ImageResource(downloadURL: moviePosterUrl, cacheKey: movie.title)
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(with: resource)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateUI()
        guard let vm = viewModel else { return }
        
        if vm.hasReview() {
            displayReview()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddReviewTableViewController {
            guard let movie = viewModel?.movie else { return }
            destination.viewModel = ReviewMovieViewModel(movie: movie)
        }
    }
    
    @IBAction func toggleFavourite(_ sender: UIButton) {
        guard let vm = viewModel else { return }
        
        let movie = vm.movie
        
        if vm.isFavourite() {
            StorageManager.shared.removeFromFavouriteMovies(movie: movie)
        } else {
            StorageManager.shared.add(FavouriteMovie(movie: movie))
        }
        
        updateUI()
    }
    
    private func updateUI() {
        guard let vm = viewModel else { return }
        
        addToFavouriteButton.setTitle(vm.isFavourite() ? "Remove from my favourite list" : "Add to my favourite list", for: .normal)
        
        emptyReviewView.isHidden = vm.hasReview()
        reviewView.isHidden = !vm.hasReview()
    }
    
    private func displayReview() {
        guard let vm = viewModel,
            vm.hasReview() else { return }
        
        let review = StorageManager.shared.getMovieReview(movieId: vm.movie.id)
        
        if let rating = review?.rating, let title = review?.title, let reviewText = review?.review {
            reviewRating.value = rating
            reviewTitleLabel.text = title
            reviewLabel.text = reviewText
        } else {
            reviewTitleLabel.text = "N/A"
            reviewLabel.text = "N/A"
        }
    }
    
    private func loadImageFromPath(path: String) -> UIImage? {
        guard let fileURL = StorageManager.shared.documentsUrl?.appendingPathComponent(path) else { return nil }
        
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
}

// MARK: - UITableViewDelegate
extension MovieDetailTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
