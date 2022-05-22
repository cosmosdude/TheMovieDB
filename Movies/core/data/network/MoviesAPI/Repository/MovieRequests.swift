//
//  MovieRequests.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-21.
//

import Foundation
import Alamofire


class MovieFetchRequest {
    
    let domain: String
    let apikey: String
    
    var subdomain: String { "/" }
    
    var endpoint: String { domain + subdomain }
    
    var parameters: [String: Any] { [:] }
    
    var method: HTTPMethod { .get }
    
    init(domain: String, apikey: String) {
        self.domain = domain
        self.apikey = apikey
    }
    
    private func injectedParameters() -> [String: Any] {
        var params = self.parameters
        params["api_key"] = apikey
        return params
    }
    
    func request() -> DataRequest {
        MovieApiRepository.shared.session.request(
            endpoint, method: method, parameters: injectedParameters()
        )
    }
    
}


class PaginatedMovieFetchRequest: MovieFetchRequest {
    
    private(set) var page: Int = 1
    
    func page(_ value: Int) -> Self {
        self.page = value ; return self
    }
    
    override var parameters: [String : Any] {
        ["page": page]
    }
    
}


class UpcomingMoviesFetchRequest: PaginatedMovieFetchRequest {
    
    override var subdomain: String
    { super.subdomain + "movie/upcoming" }
    
}


class PopularMoviesFetchRequest: PaginatedMovieFetchRequest {
    
    override var subdomain: String
    { super.subdomain + "movie/popular" }
    
}

class MovieDetailFetchRequest: MovieFetchRequest {
    
    private var movieId: String = "0"
    
    override var subdomain: String
    { super.subdomain + "movie/" + movieId }
    
    func movieId(_ value: Int) -> Self {
        movieId = String(value) ; return self
    }
    
    func movieId(_ value: String) -> Self {
        movieId = value ; return self
    }
    
}
