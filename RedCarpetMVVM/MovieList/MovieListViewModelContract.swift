//
//  MovieListViewModelContract.swift
//  RedCarpetMVVM
//
//  Created by Göksel Köksal on 16.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation
import Commons

enum MovieListViewModelChange {
    case didUpdateMovies
    case didEncounterError(Error)
    case didChangeNetworkActivityStatus(Bool)
}

protocol MovieListViewModelProtocol {
    
    var movies: [Movie] { get }
    var changeHandler: ((MovieListViewModelChange) -> Void)? { get set }
    
    func fetchMovies()
}
