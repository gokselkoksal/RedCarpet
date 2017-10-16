//
//  AppLauncher.swift
//  RedCarpetMVC
//
//  Created by Göksel Köksal on 7.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import UIKit
import Commons

final class AppLauncher {
    
    static func initialViewController() -> UIViewController {
        let vc = MovieListViewController()
        #if MOCK
            vc.service = MockMovieService()
        #else
            vc.service = MovieService()
        #endif
        let nc = UINavigationController(rootViewController: vc)
        return nc
    }
}
