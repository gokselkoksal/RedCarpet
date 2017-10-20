//
//  MovieListInteractor.swift
//  RedCarpetVIPER
//
//  Created by Göksel Köksal on 16.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation
import Commons

final class MovieListInteractor: MovieListInteractorProtocol {
    
    let service: MovieServiceProtocol
    weak var output: MovieListInteractorOutput?
    
    init(service: MovieServiceProtocol) {
        self.service = service
    }
    
    func fetchMovies() {
        output?.receiveNetworkActivityStatus(isActive: true)
        
        service.fetchMovies { [weak self] (result) in
            guard let strongSelf = self else { return }
            
            strongSelf.output?.receiveNetworkActivityStatus(isActive: false)
            
            switch result {
            case .success(let movies):
                strongSelf.output?.receiveMovies(movies)
            case .failure(let error):
                strongSelf.output?.receiveError(error)
            }
        }
    }
}
