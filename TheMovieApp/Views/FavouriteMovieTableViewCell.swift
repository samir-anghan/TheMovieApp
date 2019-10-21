//
//  FavouriteMovieTableViewCell.swift
//  TheMovieApp
//
//  Created by Samir on 10/20/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//

import UIKit

class FavouriteMovieTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "FavouriteMovieTableViewCellIdentifier"
    
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
