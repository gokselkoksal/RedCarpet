//
//  MockMovieService.swift
//  Commons
//
//  Created by Göksel Köksal on 7.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation

public class MockMovieService: MovieServiceProtocol {
    
    public enum Error: Swift.Error {
        case loadFailed
    }
    
    public init() {
        // Noop.
    }
    
    public func fetchMovies(_ completion: @escaping (Result<[Movie]>) -> Void) {
        guard let json = loadMockJSON() else {
            completion(Result<[Movie]>.failure(Error.loadFailed))
            return
        }
        
        let result = MovieSerializer.shared.serialize(json: json)
        completion(result)
    }
    
    private func loadMockJSON() -> Any? {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "movies-response", withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return json
        } catch {
            return nil
        }
    }
}
