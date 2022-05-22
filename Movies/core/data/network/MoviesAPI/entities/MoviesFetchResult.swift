//
//  MoviesFetchResult.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-21.
//

import Foundation

struct MoviesFetchResult: Decodable {
    
    var page: Int
    var totalPages: Int
    var totalResults: Int
    var results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results
    }
}
