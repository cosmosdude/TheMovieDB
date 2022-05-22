//
//  MovieDetailPresenter.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-22.
//

import Foundation

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    weak var output: MovieDetailViewProtocol?
    
    func handle(movie: MovieDAO) {
        let vm = MovieDetailViewModel(
            image: URL(string:movie.backdropURL),
            title: movie.title,
            isFavourite: movie.favourite,
            rating: "\(Int(movie.rating * 10)) %",
            description: movie.overview
        )
        DispatchQueue.main.async {
            self.output?.render(viewModel: vm)
        }
        
    }
    
    func handle(offline flag: Bool) {
        DispatchQueue.main.async {
            self.output?.render(offline: flag)
        }
        
    }
}
