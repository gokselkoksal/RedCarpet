//
//  NavigationEngine.swift
//  RedCarpetRedux
//
//  Created by Göksel Köksal on 29.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import UIKit
import Commons

class NavigationEngine: Subscriber {
    
    private(set) var oldState: NavigationState?
    let rootNavigationController: UINavigationController
    
    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
        core.add(subscriber: self, notifyOnQueue: .main, selector: { $0.navigationState })
    }
    
    func update(with state: NavigationState) {
        if let oldState = oldState, state.lastEvent == oldState.lastEvent {
            return
        }
        
        oldState = state
        
        switch state.lastEvent {
        case .showMovieList:
            let vc = MovieListViewController()
            #if MOCK
                let service: MovieServiceProtocol = MockMovieService()
            #else
                let service: MovieServiceProtocol = MovieService()
            #endif
            let presenter = MovieListPresenter(view: vc, service: service)
            vc.presenter = presenter
            rootNavigationController.setViewControllers([vc], animated: false)
            
        case .showDetailScreen(movie: let movie):
            let vc = MovieDetailViewController()
            let presenter = MovieDetailPresenter(movie: movie)
            vc.presenter = presenter
            rootNavigationController.pushViewController(vc, animated: true)
            
        case .didCloseDetailScreen:
            // UIKit handles.
            break
        }
    }
}
