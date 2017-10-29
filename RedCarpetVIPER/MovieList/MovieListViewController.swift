//
//  MovieListViewController.swift
//  RedCarpetVIPER
//
//  Created by Göksel Köksal on 8.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import UIKit
import Commons

final class MovieListViewController: UITableViewController {
    
    var presenter: MovieListPresenterProtocol!
    
    private var moviePresentations: [MovieListPresentation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie List"
        presenter.didLoad()
    }
}

extension MovieListViewController: MovieListViewProtocol {
    
    func updateMoviePresentations(_ presentations: [MovieListPresentation]) {
        self.moviePresentations = presentations
        tableView.reloadData()
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
    
    func setLoading(_ flag: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = flag
    }
}

// MARK: - UITableViewDataSource

extension MovieListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviePresentations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let cellId = "defaultCell"
        
        if let someCell = tableView.dequeueReusableCell(withIdentifier: cellId) {
            cell = someCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        let presentation = moviePresentations[indexPath.row]
        
        cell.textLabel?.text = presentation.title
        cell.detailTextLabel?.text = presentation.detail
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MovieListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.didTapOnMovie(at: indexPath.row)
    }
}
