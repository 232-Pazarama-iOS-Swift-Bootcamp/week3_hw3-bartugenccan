//
//  EbookResponse.swift
//  iTunes Client App
//
//  Created by Bartu Gençcan on 14.10.2022.
//

import Foundation

struct EbookResponse: Decodable {
    let resultCount: Int?
    let results: [Ebook]?
}
