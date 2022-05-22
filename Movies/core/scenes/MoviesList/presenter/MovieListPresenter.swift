//
//  MovieListPresenter.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-22.
//

import Foundation

class MovieListPresenter: MovieListPresenterProtocol {
    
    weak var output: MovieListViewProtocol?
    
}

extension MovieListPresenter {
    
    private func movieViewModel(from movie: MovieDAO) -> MovieViewModel {
        MovieViewModel(
            id: movie.id,
            name: movie.title,
            rating: "\(Int(movie.rating * 10)) %",
            image: URL(string: movie.posterURL),
            isFavourite: movie.favourite
        )
    }
    
    private func movieViewModels(
        from movies: [MovieDAO]
    ) -> [MovieViewModel] {
        movies.map(movieViewModel(from:))
    }
    
    func handle(popularMovies: [MovieDAO]) {
        guard popularMovies.isEmpty == false else { return }
        DispatchQueue.main.async {
            self.output?.render(popularMoviesLoading: false)
            self.output?.render(
                popularMovies: self.movieViewModels(from: popularMovies)
            )
        }
    }
    
    func handle(upcomingMovies: [MovieDAO]) {
        guard upcomingMovies.isEmpty == false else { return }
        DispatchQueue.main.async {
            
            self.output?.render(upcomingMoviesLoading: false)
            self.output?.render(
                upcomingMovies: self.movieViewModels(from: upcomingMovies)
            )
        }
    }
    
    
    func handle(isOffline: Bool, error: Error?) {
        DispatchQueue.main.async {
            self.output?.render(offline: isOffline)
            if let error = error {
                self.output?.render(error: error.localizedDescription)
            }
        }
    }
    
    func update(with movie: MovieDAO) {
        DispatchQueue.main.async {
            self.output?.render(
                updated: self.movieViewModel(from: movie)
            )
        }
        
    }
    
}
