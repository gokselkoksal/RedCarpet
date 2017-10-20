//
//  MovieDetailPresenter.swift
//  RedCarpetVIPER
//
//  Created by Göksel Köksal on 20.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation
import Commons

protocol MovieDetailPresenterProtocol {
    var moviePresentation: MovieDetailPresentation { get }
}

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    let moviePresentation: MovieDetailPresentation
    
    init(moviePresentation: MovieDetailPresentation) {
        self.moviePresentation = moviePresentation
    }
}
