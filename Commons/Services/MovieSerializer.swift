//
//  MovieSerializer.swift
//  Commons
//
//  Created by Göksel Köksal on 7.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation
import Unbox

class MovieSerializer {
    
    enum Error: Swift.Error {
        case invalidResponse
    }
    
    static let shared = MovieSerializer()
    
    func serialize(json: Any) -> Result<[Movie]> {
        do {
            guard let json = json as? [String: Any] else {
                let result = Result<[Movie]>.failure(Error.invalidResponse)
                return result
            }
            let response: MovieResponse = try unbox(dictionary: json)
            let movies = response.results
            let result = Result<[Movie]>.success(movies)
            return result
        } catch {
            let result = Result<[Movie]>.failure(Error.invalidResponse)
            return result
        }
    }
}
