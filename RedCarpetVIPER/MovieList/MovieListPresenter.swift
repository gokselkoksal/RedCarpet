//
//  MovieListPresenter.swift
//  RedCarpetVIPER
//
//  Created by Göksel Köksal on 16.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation
import Commons

final class MovieListPresenter {
    
    private let interactor: MovieListInteractorProtocol
    private let router: MovieListRouterProtocol
    
    weak var view: MovieListViewProtocol?
    
    private var movies: [Movie] = []
    
    init(interactor: MovieListInteractorProtocol,
         router: MovieListRouter,
         view: MovieListViewProtocol) {
        
        self.interactor = interactor
        self.router = router
        self.view = view
        
        self.interactor.output = self
    }
}

extension MovieListPresenter: MovieListPresenterProtocol {
    
    func didLoad() {
        interactor.fetchMovies()
    }
    
    func didTapOnMovie(at index: Int) {
        let movie = movies[index]
        let presentation = MovieDetailPresentation(movie: movie)
        router.showMovieDetail(with: presentation)
    }
}

extension MovieListPresenter: MovieListInteractorOutput {
    
    func receiveError(_ error: Error) {
        view?.handleError(error)
    }
    
    func receiveMovies(_ movies: [Movie]) {
        self.movies = movies
        let presentations = movies.map { MovieListPresentation(movie: $0) }
        view?.updateMoviePresentations(presentations)
    }
    
    func receiveNetworkActivityStatus(isActive: Bool) {
        view?.setLoading(isActive)
    }
}
