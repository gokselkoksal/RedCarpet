//
//  Array+Movie.swift
//  Commons
//
//  Created by Göksel Köksal on 7.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation

extension Array where Element == Movie {
    
    func filter(withKeyword keyword: String) -> [Element] {
        let key = keyword.lowercased()
        
        func check(_ word: String) -> Bool {
            return word.lowercased().contains(key)
        }
        
        return self.filter { (movie) -> Bool in
            let nameFlag = check(movie.name)
            let artistNameFlag = check(movie.artistName)
            
            return nameFlag || artistNameFlag
        }
    }
}
