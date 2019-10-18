//
//  MainViewController.swift
//  TheMovieApp
//
//  Created by Samir on 10/17/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var movieListTableView: UITableView!
    @IBOutlet weak var tableViewActivityIndicator: UIActivityIndicatorView!
    
    private var viewModel: MovieListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MovieListViewModel()
        viewModel?.delegate = self
        viewModel?.fetchMovies()
        setupTableView()
    }

}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    private func setupTableView() {
        movieListTableView.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: MovieListTableViewCell.reuseIdentifier)
       
        movieListTableView.estimatedRowHeight = 150
        movieListTableView.rowHeight = 150
        
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.reuseIdentifier) as? MovieListTableViewCell,
            let movie = viewModel?.dataSource[indexPath.row]
            else { return UITableViewCell() }
        
        cell.config(movie: movie)
        return cell
    }
}

// MARK: - MovieListViewModelDelegate
extension MainViewController: MovieListViewModelDelegate {
    func dataReady() {
        movieListTableView.reloadData()
        tableViewActivityIndicator.stopAnimating()
    }
    
    func loading() {
        tableViewActivityIndicator.startAnimating()
    }
}


