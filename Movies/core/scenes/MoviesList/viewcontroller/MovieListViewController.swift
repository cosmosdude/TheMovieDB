//
//  MovieListViewController.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-22.
//

import UIKit
import RxSwift

class MovieListViewController: UIViewController, MovieListViewProtocol {

    weak var coordinator: MovieListCoordinator?
    
    var output: MovieListInteractorProtocol?
    
    @IBOutlet private var popularListView: MovieListCollectionView!
    @IBOutlet private var upcomingListView: MovieListCollectionView!
    
    @IBOutlet private var offlineIndicator: UIView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.getPopularMoviesIfCached()
        output?.getUpcomingMoviesIfCached()
        
        hookToggle(popularListView.onFavouriteToggled)
        hookToggle(upcomingListView.onFavouriteToggled)
        
        popularListView.onSelect
            .subscribe(onNext: { [weak self] item in
                self?.coordinator?.showDetail(id: item.id)
            })
            .disposed(by: disposeBag)
        
        upcomingListView.onSelect
            .subscribe(onNext: { [weak self] item in
                self?.coordinator?.showDetail(id: item.id)
            })
            .disposed(by: disposeBag)
    }
    
    private func hookToggle(_ hook: Observable<MovieViewModel>) {
        let output = output
        hook.subscribe(onNext: {
            output?.toggleFavourite(id: $0.id)
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        output?.getPopularMovies()
        output?.getUpcomingMovies()
    }
    
    
    
}

extension MovieListViewController {
    
    func render(popularMovies: [MovieViewModel]) {
        popularListView.viewModels = popularMovies
    }
    
    
    func render(upcomingMovies: [MovieViewModel]) {
        upcomingListView.viewModels = upcomingMovies
    }
    
    func render(offline flag: Bool) {
        offlineIndicator.isHidden = !flag
    }
    
    func render(error: String) {
        
    }
    
    func render(updated movie: MovieViewModel) {
        popularListView.update(model: movie)
        upcomingListView.update(model: movie)
    }
    
    func render(popularMoviesLoading flag: Bool) {
        popularListView.render(loading: flag)
    }
    
    func render(upcomingMoviesLoading flag: Bool) {
        upcomingListView.render(loading: flag)
    }
    
}
