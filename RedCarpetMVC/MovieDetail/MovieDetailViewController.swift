//
//  MovieDetailViewController.swift
//  RedCarpetMVC
//
//  Created by Göksel Köksal on 7.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import UIKit
import Commons

final class MovieDetailViewController: UIViewController {
    
    var movie: Movie!

    override func loadView() {
        let myView = MovieDetailView.instantiate()
        self.view = myView
    }
    
    var myView: MovieDetailView {
        return view as! MovieDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie Detail"
        myView.movie = movie
    }
}
