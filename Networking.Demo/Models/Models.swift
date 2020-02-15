//
//  SearchResult.swift
//  Networking.Demo
//
//  Created by Art Arriaga on 2/14/20.
//  Copyright © 2020 ArturoArriaga.IO. All rights reserved.
//

import Foundation

struct iTunesSearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let artistName: String
    let shortDescription: String?
    let trackName: String?
}
