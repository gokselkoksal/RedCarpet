//
//  MovieListViewController.swift
//  RedCarpet
//
//  Created by Göksel Köksal on 7.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import UIKit
import Commons

class MovieListViewController: UIViewController {
    
    var service: MovieServiceProtocol = MovieService()
    
    override func loadView() {
        self.view = MovieListView.instantiate()
    }
    
    var myView: MovieListView {
        return view as! MovieListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
    }
}

private extension MovieListViewController {
    
    func fetchMovies() {
        setLoading(true)
        
        service.fetchMovies { [weak self] (result) in
            guard let strongSelf = self else { return }
            
            strongSelf.setLoading(false)
            
            switch result {
            case .success(let movies):
                strongSelf.myView.movies = movies
            case .failure(let error):
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
