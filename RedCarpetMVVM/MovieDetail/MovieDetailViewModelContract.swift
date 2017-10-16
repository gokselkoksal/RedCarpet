//
//  MovieDetailViewModelContract.swift
//  RedCarpetMVVM
//
//  Created by Göksel Köksal on 16.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation
import Commons

protocol MovieDetailViewModelProtocol {
    var movie: Movie { get }
    init(movie: Movie)
}
