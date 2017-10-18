//
//  AppRouter.swift
//  RedCarpetMVVM
//
//  Created by Göksel Köksal on 18.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import UIKit
import Commons

final class AppRouter {
    
    static let shared = AppRouter()
    
    func configureInitialViewController(_ viewController: UIViewController) {
        let initialVC: UIViewController
        
        if let nc = viewController as? UINavigationController {
            initialVC = nc.viewControllers.first! // Can't recover if nil.
        } else {
            initialVC = viewController
        }
        
        guard let vc = initialVC as? MovieListViewController else {
            fatalError()
        }
        
        configureMovieListViewController(vc)
    }
    
    private func configureMovieListViewController(_ vc: MovieListViewController) {
        #if MOCK
            let service = MockMovieService()
        #else
            let service = MovieService()
        #endif
        
        let viewModel = MovieListViewModel(service: service)
        vc.viewModel = viewModel
    }
}
