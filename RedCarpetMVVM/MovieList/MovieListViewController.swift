//
//  MovieListViewController.swift
//  RedCarpetMVVM
//
//  Created by Göksel Köksal on 16.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import UIKit
import Commons

final class MovieListViewController: UITableViewController {
    
    private enum SegueId {
        static let detail = "showDetail"
    }
    
    var viewModel: MovieListViewModelProtocol!
    
    private var movies: [Movie] {
        return viewModel.movies
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie List"
        bindViewModel()
        viewModel.fetchMovies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueId.detail,
           let movie = sender as? Movie,
           let destination = segue.destination as? MovieDetailViewController {
            destination.viewModel = MovieDetailViewModel(movie: movie)
        }
    }
}

private extension MovieListViewController {
    
    func bindViewModel() {
        viewModel.changeHandler = { [weak self] change in
            guard let strongSelf = self else { return }
            
            switch change {
            case .didChangeNetworkActivityStatus(let isActive):
                strongSelf.setLoading(isActive)
            case .didUpdateMovies:
                strongSelf.tableView.reloadData()
            case .didEncounterError(let error):
                strongSelf.handleError(error)
            }
        }
    }
    
    func setLoading(_ flag: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = flag
    }
    
    func handleError(_ error: Error) {
        let alert = UIAlertController(
            title: "API Error",
            message: "Could not fetch movies at this time.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension MovieListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let cellId = "defaultCell"
        
        if let someCell = tableView.dequeueReusableCell(withIdentifier: cellId) {
            cell = someCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        let movie = movies[indexPath.row]
        let presentation = MovieListPresentation(movie: movie)
        
        cell.textLabel?.text = presentation.title
        cell.detailTextLabel?.text = presentation.detail
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MovieListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let movie = movies[indexPath.row]
        performSegue(withIdentifier: SegueId.detail, sender: movie)
    }
}
