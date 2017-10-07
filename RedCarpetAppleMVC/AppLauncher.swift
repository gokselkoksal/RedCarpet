//
//  AppLauncher.swift
//  RedCarpetAppleMVC
//
//  Created by Göksel Köksal on 7.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import UIKit

class AppLauncher {
    
    static func initialViewController() -> UIViewController {
        let vc = MovieListViewController()
        let nc = UINavigationController(rootViewController: vc)
        return nc
    }
}
