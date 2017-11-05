//
//  AppLogic.swift
//  RedCarpetRedux
//
//  Created by Göksel Köksal on 29.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation

#if DEBUG
    private let middlewares: [AnyMiddleware] = [LoggerMiddleware()]
#else
    private let middlewares: [AnyMiddleware] = []
#endif

let core = Core(
    state: AppState(),
    middlewares: middlewares
)

struct AppState: State {
    var navigationState: NavigationState = NavigationState(event: NavigationEvent.showMovieList)
    var movieListState: MovieListState = MovieListState()
    var movieDetailState: MovieDetailState?
}

extension AppState {
    
    mutating func react(to event: Event) {
        if let event = event as? NavigationEvent {
            switch event {
            case .showMovieList:
                break // Noop.
            case .showDetailScreen(movie: let movie):
                movieDetailState = MovieDetailState(movie: movie)
            case .didCloseDetailScreen:
                movieDetailState = nil
            }
            navigationState.react(to: event)
        }
        
        movieListState.react(to: event)
        movieDetailState?.react(to: event)
    }
}
