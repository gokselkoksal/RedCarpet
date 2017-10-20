//
//  MovieListContracts.swift
//  RedCarpetVIPER
//
//  Created by Göksel Köksal on 16.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation
import Commons

protocol MovieListInteractorProtocol: class {
    weak var output: MovieListInteractorOutput? { get set }
    func fetchMovies()
}

protocol MovieListInteractorOutput: class {
    func receiveMovies(_ movies: [Movie])
    func receiveNetworkActivityStatus(isActive: Bool)
    func receiveError(_ error: Error)
}

protocol MovieListPresenterProtocol: class {
    func didLoad()
    func didTapOnMovie(at index: Int)
}

protocol MovieListViewProtocol: class {
    func updateMoviePresentations(_ presentations: [MovieListPresentation])
    func handleError(_ error: Error)
    func setLoading(_ flag: Bool)
}

protocol MovieListRouterProtocol: class {
    func showMovieDetail(with presentation: MovieDetailPresentation)
}
