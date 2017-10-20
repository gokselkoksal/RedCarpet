//
//  MovieListRouter.swift
//  RedCarpetVIPER
//
//  Created by Göksel Köksal on 16.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import UIKit
import Commons

final class MovieListRouter: MovieListRouterProtocol {
    
    private weak var view: (UIViewController & MovieListViewProtocol)?
    
    init(view: (UIViewController & MovieListViewProtocol)) {
        self.view = view
    }
    
    func showMovieDetail(with presentation: MovieDetailPresentation) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let id = String(describing: MovieDetailViewController.self)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: id) as? MovieDetailViewController else {
            return
        }
        
        let presenter = MovieDetailPresenter(moviePresentation: presentation)
        vc.presenter = presenter
        
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}
