//
//  MovieListContracts.swift
//  RedCarpetVIPER
//
//  Created by Göksel Köksal on 16.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation
import Commons

protocol MovieListProviderProtocol: class {
    weak var output: MovieListProviderOutputProtocol? { get set }
    func fetchMovies()
}

protocol MovieListProviderOutputProtocol: class {
    func receiveMovies(_ movies: [Movie])
    func receiveNetworkActivityStatus(isActive: Bool)
    func receiveError(_ error: Error)
}

protocol MovieListEventHandlerProtocol: class {
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
