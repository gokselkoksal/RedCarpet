//
//  AppLauncher.swift
//  RedCarpetRedux
//
//  Created by Göksel Köksal on 29.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import UIKit

final class AppLauncher {
    
    static let shared = AppLauncher()
    
    var navigationEngine: NavigationEngine!
    
    func initialViewController() -> UIViewController {
        let nc = UINavigationController()
        navigationEngine = NavigationEngine(rootNavigationController: nc)
        return nc
    }
}
