//
//  MovieDetailPresenter.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-22.
//

import Foundation
import RxCocoa
import RxSwift

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    weak var output: MovieDetailViewProtocol?
    
    private var offlineState = PublishSubject<Bool>()
    private var viewModel = PublishSubject<MovieDetailViewModel>()
    
    func bind(to output: MovieDetailViewProtocol?) {
        output?.offlineState = offlineState
            .asDriver(onErrorJustReturn: false)
        output?.viewModelChange = viewModel.asDriver(
            onErrorJustReturn: .init()
        )
    }
    
    func handle(movie: MovieDAO) {
        let vm = MovieDetailViewModel(
            image: URL(string:movie.backdropURL),
            title: movie.title,
            isFavourite: movie.favourite,
            rating: "\(Int(movie.rating * 10)) %",
            description: movie.overview
        )
        viewModel.onNext(vm)
    }
    
    func handle(offline flag: Bool) {
        offlineState.onNext(flag)
    }
    
}
