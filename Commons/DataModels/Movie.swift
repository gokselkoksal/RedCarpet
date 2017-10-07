//
//  Movie.swift
//  Commons
//
//  Created by Göksel Köksal on 7.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import Foundation

public struct Movie: Codable {
    
    public enum CodingKeys: String, CodingKey {
        case id
        case artistName
        case artworkURL = "artworkUrl100"
        case name
        case releaseDate
        case copyright
    }
    
    public let id: String
    public let artistName: String
    public let artworkURL: URL
    public let name: String
    public let releaseDate: Date
    public let copyright: String?
}
