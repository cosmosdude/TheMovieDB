//
//  MovieAPIRepository.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-21.
//

import Foundation
import Alamofire

class MovieApiRepository {
    
    static var shared: MovieApiRepository!
    
    let session: Session
    
    let domain: String
    let apikey: String
    
    init(domain: String, apikey: String) {
        self.domain = domain
        self.apikey = apikey
        
        let config = URLSessionConfiguration.ephemeral
        session = Session(configuration: config)
    }
    
}


extension MovieApiRepository {
    
    func upcoming() -> UpcomingMoviesFetchRequest {
        .init(domain: domain, apikey: apikey)
    }
    
    func popular() -> PopularMoviesFetchRequest {
        .init(domain: domain, apikey: apikey)
    }
    
    func detail() -> MovieDetailFetchRequest {
        .init(domain: domain, apikey: apikey)
    }
    
}
