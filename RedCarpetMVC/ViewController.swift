//
//  ViewController.swift
//  RedCarpet
//
//  Created by Göksel Köksal on 7.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import UIKit
import Commons

class ViewController: UIViewController {
    
    let service: MovieServiceProtocol = MovieService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.fetchMovies { (result) in
            print(result)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

