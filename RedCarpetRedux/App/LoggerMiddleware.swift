//
//  LoggerMiddleware.swift
//  RedCarpetRedux
//
//  Created by Göksel Köksal on 29.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation

class LoggerMiddleware: Middleware {
    
    func process(event: Event, state: AppState) {
        print("EVENT:", event)
    }
}
