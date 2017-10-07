//
//  MovieResponse.swift
//  Commons
//
//  Created by Göksel Köksal on 7.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation
import Unbox

struct MovieResponse {
    let results: [Movie]
}

extension MovieResponse: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.results = try unboxer.unbox(keyPath: "feed.results")
    }
}
