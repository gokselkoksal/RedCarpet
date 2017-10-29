//
//  Movie.swift
//  Commons
//
//  Created by Göksel Köksal on 7.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation
import Unbox

public struct Movie {
    
    public let id: String
    public let artistName: String
    public let artworkURL: URL
    public let name: String
    public let releaseDate: Date
    public let copyright: String?
    
    static let releaseDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }()
}

extension Movie: CustomStringConvertible {
    
    public var description: String {
        return name
    }
}

extension Movie: Unboxable {
    
    public init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.artistName = try unboxer.unbox(key: "artistName")
        self.artworkURL = try unboxer.unbox(key: "artworkUrl100")
        self.name = try unboxer.unbox(key: "name")
        self.releaseDate = try unboxer.unbox(key: "releaseDate", formatter: Movie.releaseDateFormatter)
        self.copyright = unboxer.unbox(key: "copyright")
    }
}
