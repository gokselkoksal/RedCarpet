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

public protocol MovieServiceProtocol {
    func fetchMovies(_ completion: @escaping (Result<[Movie]>) -> Void)
}

public class MovieService: MovieServiceProtocol {
    
    public enum Error: Swift.Error {
        case invalidResponse
    }
    
    private let session: SessionManager
    
    public init() {
        self.session = SessionManager.default
    }
    
    public func fetchMovies(_ completion: @escaping  (Result<[Movie]>) -> Void) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/25/explicit.json"
        
        session.request(urlString).responseJSON { (response) in
            switch response.result {
            case .success(let rawJSON):
                do {
                    guard let json = rawJSON as? [String: Any] else {
                        let result = Result<[Movie]>.failure(Error.invalidResponse)
                        completion(result)
                        return
                    }
                    let response: MovieResponse = try unbox(dictionary: json)
                    let movies = response.results
                    let result = Result<[Movie]>.success(movies)
                    completion(result)
                } catch {
                    let result = Result<[Movie]>.failure(Error.invalidResponse)
                    completion(result)
                }
            case .failure(let error):
                let result = Result<[Movie]>.failure(error)
                completion(result)
            }
        }
    }
}
