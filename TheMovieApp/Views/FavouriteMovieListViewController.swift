//
//  FavouriteMovieListViewController.swift
//  TheMovieApp
//
//  Created by Samir on 10/18/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//

import UIKit
import RealmSwift

class FavouriteMovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
        tableView.reloadData()
    }
    
    private func updateUI() {
        emptyView.isHidden = !StorageManager.shared.getFavouriteMovies().isEmpty
    }
}

// MARK: - UITableViewDataSource
extension FavouriteMovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StorageManager.shared.getFavouriteMovies().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteMovieTableViewCell.reuseIdentifier) as? FavouriteMovieTableViewCell else { return UITableViewCell() }
        
        let movies = StorageManager.shared.getFavouriteMovies()
        let movie = movies[indexPath.row]
        
        cell.title.text = movie.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movies = StorageManager.shared.getFavouriteMovies()
            StorageManager.shared.delete(movies[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateUI()
        }
    }
}

// MARK: - UITableViewDelegate
extension FavouriteMovieListViewController: UITableViewDelegate {
    private func setupTableView() {
        tableView.register(UINib(nibName: "FavouriteMovieTableViewCell", bundle: nil), forCellReuseIdentifier: FavouriteMovieTableViewCell.reuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
