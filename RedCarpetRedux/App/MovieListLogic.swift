//
//  MovieListComponents.swift
//  RedCarpetRedux
//
//  Created by Göksel Köksal on 29.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation
import Commons

// MARK: Actions

enum MovieListEvent: Event {
    case incrementActivityCount
    case decrementActivityCount
    case setMovieFetchResult(Result<[Movie]>)
}

// MARK: Async Actions

class MovieFetchCommand: Command {
    
    let service: MovieServiceProtocol
    
    init(service: MovieServiceProtocol) {
        self.service = service
    }
    
    func execute(state: AppState, core: Core<AppState>) {
        core.fire(event: MovieListEvent.incrementActivityCount)
        service.fetchMovies { (result) in
            core.fire(event: MovieListEvent.decrementActivityCount)
            core.fire(event: MovieListEvent.setMovieFetchResult(result))
        }
    }
}

// MARK: State

struct MovieListState: State {
    var movieFetchResult: Result<[Movie]> = Result.success([])
    var activityState = ActivityState()
}

// MARK: Reducer

extension MovieListState {
    
    mutating func react(to event: Event) {
        guard let event = event as? MovieListEvent else { return }
        
        switch event {
        case .incrementActivityCount:
            self.activityState.add()
        case .decrementActivityCount:
            try? self.activityState.remove()
        case .setMovieFetchResult(let result):
            self.movieFetchResult = result
        }
    }
}
