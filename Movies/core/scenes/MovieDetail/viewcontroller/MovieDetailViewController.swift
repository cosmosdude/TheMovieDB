//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-22.
//

import UIKit
import Kingfisher
import RxCocoa
import RxSwift

class MovieDetailViewController: UIViewController {

    weak var coordinator: MovieDetailCoordinator?

    var output: MovieDetailInteractorProtocol?
    
    var offlineState: Driver<Bool>!
    var viewModelChange: Driver<MovieDetailViewModel>!
    
    @IBOutlet private var offlineView: UIView!
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var heartButton: UIButton!
    @IBOutlet private var ratingLabel: UILabel!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heartButton.rx.tap.subscribe { [weak self] _ in
            self?.output?.toggleFavourite()
        }.disposed(by: bag)
        
        offlineState?.map(!)
            .drive(offlineView.rx.isHidden)
            .disposed(by: bag)
        
        viewModelChange?.map(\.title)
            .drive(titleLabel.rx.text)
            .disposed(by: bag)
        
        viewModelChange?.map {
                $0.isFavourite ? R.Icon.heartFill : R.Icon.heart
            }.drive(heartButton.rx.image(for: .normal))
            .disposed(by: bag)
        
        viewModelChange?.map(\.rating)
            .drive(ratingLabel.rx.text)
            .disposed(by: bag)
        
        viewModelChange?.map(\.description)
            .drive(descriptionLabel.rx.text)
            .disposed(by: bag)
        
        viewModelChange?.map(\.image)
            .drive(onNext: { [weak self] in
                self?.imageView?.kf.setImage(with: $0)
            })
            .disposed(by: bag)
        
        output?.getCachedMovieDetail()
        
        NotificationCenter.default
            .rx.notification(ReachabilityEvent.reachable)
            .subscribe { [weak self] _ in
                self?.output?.getMovieDetail()
            }.disposed(by: bag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output?.getMovieDetail()
    }
    
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    
    func render(viewModel: MovieDetailViewModel) {
        imageView.kf.setImage(with: viewModel.image)
        titleLabel.text = viewModel.title
        ratingLabel.text = viewModel.rating
        descriptionLabel.text = viewModel.description
        heartButton.setImage(
            viewModel.isFavourite ? R.Icon.heartFill : R.Icon.heart,
            for: .normal
        )
    }
    
}
