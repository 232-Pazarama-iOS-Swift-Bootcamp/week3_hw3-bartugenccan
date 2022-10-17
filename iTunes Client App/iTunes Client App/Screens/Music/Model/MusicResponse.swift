//
//  MusicResponse.swift
//  iTunes Client App
//
//  Created by Bartu Gençcan on 16.10.2022.
//


import Foundation

struct MusicResponse: Decodable {
    let resultCount: Int?
    let results: [Music]?
}
