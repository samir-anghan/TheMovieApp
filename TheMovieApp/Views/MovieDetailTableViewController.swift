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

class MovieDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var starRatingView: SwiftyStarRatingView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var viewModel: MovieDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let vm = viewModel else { return }
        
        let movie = vm.movie
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        
        let rating = CGFloat(ceil(movie.voteAverage / 2))
        starRatingView.value = rating
        ratingLabel.text = "\(rating)/5"
        votesLabel.text = "(\(movie.totalVotes) votes)"
        releaseDateLabel.text = DateStringFormatter.format(dateString: movie.releaseDate ?? "N/A")
        
        guard let posterPath = movie.posterPath,
            let moviePosterUrl = URL(string: "http://image.tmdb.org/t/p/w500\(posterPath)") else { return }
        
        let resource = ImageResource(downloadURL: moviePosterUrl, cacheKey: movie.title)
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(with: resource)
    }
    
    // MARK: - Table view data source
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
