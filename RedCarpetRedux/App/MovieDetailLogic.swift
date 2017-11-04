//
//  MovieDetailLogic.swift
//  RedCarpetRedux
//
//  Created by Göksel Köksal on 4.11.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation
import Commons

// MARK: State

struct MovieDetailState: State {
    var movie: Movie
}

// MARK: Reducer

extension MovieDetailState {
    
    mutating func react(to event: Event) {
        // No events to handle.
    }
}

