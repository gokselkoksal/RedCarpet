//
//  MovieDetailViewModel.swift
//  RedCarpetMVVM
//
//  Created by Göksel Köksal on 16.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation
import Commons

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
}
