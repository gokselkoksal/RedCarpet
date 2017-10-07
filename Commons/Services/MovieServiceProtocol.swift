//
//  MovieService.swift
//  Commons
//
//  Created by Göksel Köksal on 7.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation

public protocol MovieServiceProtocol {
    func fetchMovies(_ completion: @escaping (Result<[Movie]>) -> Void)
}
