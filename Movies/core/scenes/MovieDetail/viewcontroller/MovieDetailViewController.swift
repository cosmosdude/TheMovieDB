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

    var output: MovieDetailInteractoProtocol?
    
    @IBOutlet private var offlineView: UIView!
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var heartButton: UIButton!
    @IBOutlet private var ratingLabel: UILabel!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.getCachedMovieDetail()
        
        heartButton.rx.tap.subscribe { [weak self] _ in
            self?.output?.toggleFavourite()
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
    
    func render(offline flag: Bool) {
        print("Offline flag:", flag)
        offlineView.isHidden = !flag
    }
    
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
