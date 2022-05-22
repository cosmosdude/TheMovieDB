//
//  MovieDetailFetcher.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-21.
//

import Foundation

class MovieDetailFetcher {
    
    typealias ResultHandler = (Result<Movie, Error>) -> Void
    
    func fetch(id: Int, handler: @escaping ResultHandler) {
        MovieApiRepository.shared.detail().movieId(id).request()
            .responseDecodable(of: Movie.self) { response in
                switch response.result {
                case .success(let value): handler(.success(value))
                case .failure(let error): handler(.failure(error))
                }
            }
    }
    
}
