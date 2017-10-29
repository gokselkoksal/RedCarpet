//
//  NavigationLogic.swift
//  RedCarpetRedux
//
//  Created by Göksel Köksal on 29.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation
import Commons

enum NavigationEvent: Event, Equatable {
    
    case showMovieList
    case showDetailScreen(movie: Movie)
    case didCloseDetailScreen
    
    static func ==(a: NavigationEvent, b: NavigationEvent) -> Bool {
        switch (a, b) {
        case (.showMovieList, .showMovieList):
            return true
        case (.showDetailScreen(movie: _), .showDetailScreen(movie: _)):
            return true
        case (.didCloseDetailScreen, .didCloseDetailScreen):
            return true
        default:
            return false
        }
    }
}

struct NavigationState: State {
    
    var history: [NavigationEvent]
    var lastEvent: NavigationEvent
    
    init(event: NavigationEvent) {
        self.lastEvent = event
        self.history = [event]
    }
}

extension NavigationState {
    
    mutating func react(to event: Event) {
        guard let event = event as? NavigationEvent else { return }
        history.append(event)
        lastEvent = event
    }
}
