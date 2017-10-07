//
//  AppLauncher.swift
//  RedCarpetMVC
//
//  Created by Göksel Köksal on 7.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import UIKit
import Commons

class AppLauncher {
    
    static func initialViewController() -> UIViewController {
        let vc = MovieListViewController()
        vc.service = MovieService()
        // Enable for mocking:
        // vc.service = MockMovieService()
        let nc = UINavigationController(rootViewController: vc)
        return nc
    }
}
