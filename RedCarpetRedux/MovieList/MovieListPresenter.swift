//
//  MovieListPresenter.swift
//  RedCarpetRedux
//
//  Created by Göksel Köksal on 29.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation
import Commons

protocol MovieListViewProtocol: class {
    func updateMoviePresentations(_ presentations: [MovieListPresentation])
    func handleError(_ error: Error)
    func setLoading(_ flag: Bool)
}

protocol MovieListPresenterProtocol: class {
    func didLoad()
    func willAppear()
    func didDisappear()
    func didTapOnMovie(at index: Int)
}

class MovieListPresenter: MovieListPresenterProtocol {
    
    private unowned var view: MovieListViewProtocol
    private(set) var movies: [Movie] = []
    
    private let service: MovieServiceProtocol
    
    init(view: MovieListViewProtocol, service: MovieServiceProtocol) {
        self.view = view
        self.service = service
    }
    
    func didLoad() {
        core.fire(command: MovieFetchCommand(service: service))
    }
    
    func willAppear() {
        core.add(subscriber: self, notifyOnQueue: .main, selector: { $0.movieListState })
    }
    
    func didDisappear() {
        core.remove(subscriber: self)
    }
    
    func didTapOnMovie(at index: Int) {
        let movie = movies[index]
        core.fire(event: NavigationEvent.showDetailScreen(movie: movie))
    }
}
    
extension MovieListPresenter: Subscriber {
    
    func update(with state: MovieListState) {
        view.setLoading(state.isLoading)
        
        switch state.movieFetchResult {
        case .success(let movies):
            self.movies = movies
            let presentations = movies.map { MovieListPresentation(movie: $0) }
            view.updateMoviePresentations(presentations)
        case .failure(let error):
            view.handleError(error)
        }
    }
}
