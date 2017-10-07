//
//  MoviePresentation.swift
//  Commons
//
//  Created by Göksel Köksal on 7.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation

public struct MovieListPresentation {
    
    public let title: String
    public let detail: String
    
    public init(movie: Movie) {
        let year = movie.releaseDate.extract(.year)
        
        self.title = movie.name
        self.detail = "\(year) | \(movie.artistName)"
    }
}

public struct MovieDetailPresentation {
    
    public struct Info {
        public let title: String
        public let detail: String
    }
    
    public let infoList: [Info]
    
    public init(movie: Movie) {
        var infoList: [Info] = []
        
        infoList.append(Info(title: "Name", detail: movie.name))
        infoList.append(Info(title: "Starring", detail: movie.artistName))
        
        let year = "\(movie.releaseDate.extract(.year))"
        infoList.append(Info(title: "Year", detail: year))
        
        if let copyright = movie.copyright {
            infoList.append(Info(title: "Copyright", detail: copyright))
        }
        
        self.infoList = infoList
    }
}
