//
//  MovieDetailPresenter.swift
//  RedCarpetRedux
//
//  Created by Göksel Köksal on 29.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation
import Commons

protocol MovieDetailPresenterProtocol {
    var moviePresentation: MovieDetailPresentation { get }
    func didClose()
}

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    let moviePresentation: MovieDetailPresentation
    
    init(movie: Movie) {
        self.moviePresentation = MovieDetailPresentation(movie: movie)
    }
    
    func didClose() {
        core.fire(event: NavigationEvent.didCloseDetailScreen)
    }
}
