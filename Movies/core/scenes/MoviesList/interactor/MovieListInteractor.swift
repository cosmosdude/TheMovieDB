//
//  MovieListInteractor.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-22.
//

import Foundation

class MovieListInteractor: MovieListInteractorProtocol {
    
    var output: MovieListPresenterProtocol?
    
    let storage = MoviesStorage()
    
    func getPopularMoviesIfCached() {
        loadAndPassPopularMovies()
    }
    
    // MARK:- Popular
    func getPopularMovies() {
        PopularMoviesFetcher().fetch { result in
            switch result {
            case .success(let result):
                self.save(popularMovies: result.results)
                self.loadAndPassPopularMovies()
                self.output?.handle(isOffline: false, error: nil)
            case .failure(let error):
//                print()
                self.output?.handle(isOffline: true, error: error)
            }
        }
    }
    
    private func save(popularMovies: [Movie]) {
        self.storage.addOrUpdate(
            movies: popularMovies, type: "popular"
        )
    }
    
    private func loadAndPassPopularMovies() {
        let movies = storage.getMovies()
            .filter {$0.types.contains("popular")}
        output?.handle(popularMovies: movies.map{$0})
    }
    
    
    
    // MARK:- Upcoming
    func getUpcomingMoviesIfCached() {
        loadAndPassUpcomingMovies()
    }
    
    func getUpcomingMovies() {
        // fetch ahead
        UpcomingMoviesFetcher().fetch { result in
            switch result {
            case .success(let result):
                self.save(upcomingMovies: result.results)
                self.loadAndPassUpcomingMovies()
                self.output?.handle(isOffline: false, error: nil)
            case .failure(let error):
                print()
                self.output?.handle(isOffline: true, error: error)
            }
        }
    }
    
    private func save(upcomingMovies: [Movie]) {
        self.storage.addOrUpdate(
            movies: upcomingMovies, type: "upcoming"
        )
    }
    
    private func loadAndPassUpcomingMovies() {
        let movies = storage.getMovies()
            .filter {$0.types.contains("upcoming")}
         output?.handle(upcomingMovies: movies.map{$0})
    }
    
    func toggleFavourite(id: Int) {
        storage.toggleFavourite(movieId: id)
        
        if let movie = storage.getMovie(id: id) {
            output?.update(with: movie)
        }
    }
    
}


