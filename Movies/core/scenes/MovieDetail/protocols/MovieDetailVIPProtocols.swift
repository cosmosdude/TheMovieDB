//
//  MovieDetailVIPProtocols.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-22.
//

import Foundation

protocol MovieDetailViewProtocol: AnyObject {
    
    var output: MovieDetailInteractoProtocol? { get set }
    
    func render(viewModel: MovieDetailViewModel)
    
    func render(offline flag: Bool)
    
}

protocol MovieDetailInteractoProtocol: AnyObject {
    
    var output: MovieDetailPresenterProtocol? { get set }
    
    func getCachedMovieDetail()
    func getMovieDetail()
    
    func toggleFavourite()
}

protocol MovieDetailPresenterProtocol: AnyObject {
    
    var output: MovieDetailViewProtocol? { get set }
    
    func handle(movie: MovieDAO)
    
    func handle(offline flag: Bool)
    
}
