//
//  Ebook.swift
//  iTunes Client App
//
//  Created by Bartu Gençcan on 14.10.2022.
//

import Foundation

struct Ebook: Decodable {
    let artistName: String?
    let trackName: String?
    let artworkLarge: URL?
    let releaseDate: String?
    let country: String?
    let genres: [String]?
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case trackName
        case artworkLarge = "artworkUrl100"
        case releaseDate
        case country
        case genres
    }
}
