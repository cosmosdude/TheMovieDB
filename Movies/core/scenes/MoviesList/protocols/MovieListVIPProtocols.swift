//
//  MovieListVIPProtocols.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-22.
//

import Foundation

// MARK:- View
protocol MovieListViewProtocol: AnyObject {
    
    var output: MovieListInteractorProtocol? { get set }
    
    func render(popularMovies: [MovieViewModel])
    func render(popularMoviesLoading flag: Bool)
    
    func render(upcomingMovies: [MovieViewModel])
    func render(upcomingMoviesLoading flag: Bool)
    
    func render(offline flag: Bool)
    
    func render(error: String)
    
    func render(updated movie: MovieViewModel)
    
    
}



// MARK:- Interactor
protocol MovieListInteractorProtocol: AnyObject {
    
    var output: MovieListPresenterProtocol? { get set }
    
    func getPopularMoviesIfCached()
    func getPopularMovies()
    
    func getUpcomingMoviesIfCached()
    func getUpcomingMovies()
    
    func toggleFavourite(id: Int)
    
}


// MARK:- Presenter
protocol MovieListPresenterProtocol: AnyObject {
    
    var output: MovieListViewProtocol? { get set }
    
    func handle(popularMovies: [MovieDAO])
    
    func handle(upcomingMovies: [MovieDAO])
    
    func handle(isOffline: Bool, error: Error?)
    
    func update(with movie: MovieDAO)
    
}



