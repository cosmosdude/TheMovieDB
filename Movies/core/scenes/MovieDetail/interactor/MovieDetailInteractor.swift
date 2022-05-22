//
//  MovieDetailInteractor.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-22.
//

import Foundation
import RxSwift

class MovieDetailInteractor: MovieDetailInteractorProtocol {
    
    var movieId: Int
    var output: MovieDetailPresenterProtocol?
    
    let storage = MoviesStorage()
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    func getCachedMovieDetail() {
        passCachedMovie()
    }
    
    func getMovieDetail() {
        MovieDetailFetcher().fetch(id: movieId) { r in
            switch r {
            case .success(let value):
                self.passLive(movie: value)
            case .failure(let error):
                self.pass(error: error)
            }
        }
    }
    
    private func passLive(movie: Movie) {
        self.storage.updateDetail(movie: movie)
        self.passCachedMovie()
        self.output?.handle(offline: false)
    }
    
    private func passCachedMovie() {
        if let movie = storage.getMovie(id: movieId) {
            output?.handle(movie: movie)
        }
    }
    
    private func pass(error: Error) {
        self.output?.handle(offline: true)
    }
    
    
    func toggleFavourite() {
        storage.toggleFavourite(movieId: movieId)
        passCachedMovie()
    }
    
}
