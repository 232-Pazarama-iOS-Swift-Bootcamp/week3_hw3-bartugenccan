//
//  Music.swift
//  iTunes Client App
//
//  Created by Bartu Gençcan on 16.10.2022.
//

import Foundation


struct Music: Decodable {
    let artistName: String?
    let trackName: String?
    let artwork: URL?
    let trackCount: Int?
    let country: String?
    let primaryGenreName: String?
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case trackName
        case artwork = "artworkUrl100"
        case trackCount
        case country
        case primaryGenreName
        
    }
    
}
