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
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var viewModel: MovieListViewModel?
    
    private var initialSearchString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MovieListViewModel()
        viewModel?.delegate = self
        viewModel?.fetchMovies()
        setupTableView()
        setupSearchBar()
    }

    private func setupSearchBar() {
        searchBar.delegate = self
        
        if initialSearchString != "" {
            searchBar.text = initialSearchString
            viewModel?.search(terms: initialSearchString, debounced: false)
            searchBar.isLoading = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let destination = segue.destination as? MovieDetailTableViewController {
            guard let movie = sender as? Movie else { return }
            destination.viewModel = MovieDetailViewModel(movie: movie)
        }
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataToDisplay.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.reuseIdentifier) as? MovieListTableViewCell,
            let movie = viewModel?.dataToDisplay[indexPath.row]
            else { return UITableViewCell() }
        
        cell.config(movie: movie)
        return cell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "detailViewSegue", sender: viewModel?.dataToDisplay[indexPath.row])
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

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard query.count > 2 else { return }
        
        viewModel?.search(terms: query)
    }
}
