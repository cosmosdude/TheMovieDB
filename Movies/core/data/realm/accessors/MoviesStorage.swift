//
//  MoviesStorage.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-21.
//

import Foundation
import RealmSwift

class MoviesStorage {
    
    var realm: Realm {
        MoviesPersistanceManager.shared.realm
    }
    
}


extension MoviesStorage {
    
    func getMovies() -> Results<MovieDAO> {
        realm.objects(MovieDAO.self)
    }
    
    func getMovie(id: Int) -> MovieDAO? {
        realm.object(ofType: MovieDAO.self, forPrimaryKey: id)
    }
    
}


extension MoviesStorage {
    
    func addOrUpdate(movies: [Movie], type: String) {
        try! realm.write {
            for each in movies {
                self.addOrUpdate(movie: each, type: type)
            }
        }
    }
    
    func updateDetail(movie newMovie: Movie) {
        if let movie = getMovie(id: newMovie.id) {
            realm.beginWrite()
            
            movie.title = newMovie.title
            movie.backdropURL = newMovie.backdropURL?
                .absoluteString ?? ""
            movie.posterURL = newMovie.posterURL?
                .absoluteString ?? ""
            movie.overview = newMovie.overview
            movie.rating = newMovie.rating
            
            try! realm.commitWrite()
        }
    }
    
    // You should wrap this inside a write context
    private func addOrUpdate(movie newMovie: Movie, type: String) {
            
        let movie: MovieDAO
        
        if let existingMovie = getMovie(id: newMovie.id) {
            movie = existingMovie
        } else {
            movie = MovieDAO()
            movie.id = newMovie.id
            movie.overview = newMovie.overview
        }
        
        movie.title = newMovie.title
        movie.backdropURL = newMovie.backdropURL?
            .absoluteString ?? ""
        movie.posterURL = newMovie.posterURL?
            .absoluteString ?? ""
        movie.types.insert(type)
        movie.rating = newMovie.rating
        
        realm.add(movie, update: .modified)
    }
    
    
    
    
    func toggleFavourite(movieId: Int) {
        if let movie = getMovie(id: movieId) {
            realm.beginWrite()
            movie.favourite.toggle()
            try! realm.commitWrite()
        }
    }
    
}
