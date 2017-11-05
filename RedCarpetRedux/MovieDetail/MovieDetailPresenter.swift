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
    func willAppear()
    func didDisappear()
    func didClose()
}

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    let moviePresentation: MovieDetailPresentation
    
    init(movie: Movie) {
        self.moviePresentation = MovieDetailPresentation(movie: movie)
    }
    
    func willAppear() {
        core.add(subscriber: self, notifyOnQueue: .main, selector: { $0.movieDetailState as Any })
    }
    
    func didDisappear() {
        core.remove(subscriber: self)
    }
    
    func didClose() {
        core.fire(event: NavigationEvent.didCloseDetailScreen)
    }
}
    
extension MovieDetailPresenter: Subscriber {
    
    func update(with state: MovieDetailState) {
        // No movie detail state changes to handle for now.
    }
}
