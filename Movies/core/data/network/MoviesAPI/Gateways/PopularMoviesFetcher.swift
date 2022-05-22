//
//  PopularMoviesFetcher.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-21.
//

import Foundation

class PopularMoviesFetcher {
    
    typealias ResultHandler = (Result<MoviesFetchResult, Error>) -> Void
    
    func fetch(page: Int = 1, handler: @escaping ResultHandler) {
        MovieApiRepository.shared.popular().page(page).request()
            .responseDecodable(of: MoviesFetchResult.self) { response in
                switch response.result {
                case .success(let value): handler(.success(value))
                case .failure(let error): handler(.failure(error))
                }
            }
    }
    
}
