//
//  MovieDetailVIPProtocols.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-22.
//

import Foundation
import RxSwift
import RxCocoa

// MARK:- View

protocol MovieDetailViewProtocol: AnyObject {
    
    var output: MovieDetailInteractorProtocol? { get set }
    
    var offlineState: Driver<Bool>! { get set }
    var viewModelChange: Driver<MovieDetailViewModel>! { get set }
    
    func render(viewModel: MovieDetailViewModel)
    
}


// MARK:- Interactor
protocol MovieDetailInteractorProtocol: AnyObject {
    
    var output: MovieDetailPresenterProtocol? { get set }
    
    func getCachedMovieDetail()
    func getMovieDetail()
    func toggleFavourite()
}


// MARK:- Presenter
protocol MovieDetailPresenterProtocol: AnyObject {
    
    var output: MovieDetailViewProtocol? { get set }
    
    func handle(movie: MovieDAO)
    
    func handle(offline flag: Bool)
    
    func bind(to: MovieDetailViewProtocol?)
    
}
