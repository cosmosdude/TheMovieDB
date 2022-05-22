//
//  Movie.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-21.
//

import Foundation

struct Movie: Decodable {
    
    var id: Int
    var title: String
    var overview: String
    var posterURL: URL?
    var backdropURL: URL?
    var rating: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case poster = "poster_path"
        case backdrop = "backdrop_path"
        case rating = "vote_average"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        
        let imageServer = "https://image.tmdb.org/t/p/original/"
        
        let posterPath = try container.decode(
            String.self, forKey: .poster
        )
        posterURL = URL(
            string: imageServer + posterPath
        )
        
        let backdropPath = try container.decode(
            String.self, forKey: .backdrop
        )
        backdropURL = URL(
            string: imageServer + backdropPath
        )
        
        rating = try container.decode(Double.self, forKey: .rating)
    }
}
