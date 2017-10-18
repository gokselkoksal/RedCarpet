//
//  MovieListViewModel.swift
//  RedCarpetMVVM
//
//  Created by Göksel Köksal on 16.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation
import Commons

final class MovieListViewModel: MovieListViewModelProtocol {
    
    private(set) var movies: [Movie] = []
    private let service: MovieServiceProtocol
    var changeHandler: ((MovieListViewModelChange) -> Void)?
    
    init(service: MovieServiceProtocol) {
        self.service = service
    }
    
    func fetchMovies() {
        emit(.didChangeNetworkActivityStatus(true))
        
        service.fetchMovies { [weak self] (result) in
            guard let strongSelf = self else { return }
            
            strongSelf.emit(.didChangeNetworkActivityStatus(false))
            
            switch result {
            case .success(let movies):
                strongSelf.movies = movies
                strongSelf.emit(.didUpdateMovies)
            case .failure(let error):
                strongSelf.emit(.didEncounterError(error))
            }
        }
    }
    
    private func emit(_ change: MovieListViewModelChange) {
        changeHandler?(change)
    }
}
