//
//  MovieService.swift
//  Commons
//
//  Created by Göksel Köksal on 7.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

public class MovieService: MovieServiceProtocol {
    
    private let session: SessionManager
    
    public init() {
        self.session = SessionManager.default
    }
    
    public func fetchMovies(_ completion: @escaping  (Result<[Movie]>) -> Void) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/25/explicit.json"
        
        session.request(urlString).responseJSON { (response) in
            switch response.result {
            case .success(let rawJSON):
                let result = MovieSerializer.shared.serialize(json: rawJSON)
                completion(result)
            case .failure(let error):
                let result = Result<[Movie]>.failure(error)
                completion(result)
            }
        }
    }
}
