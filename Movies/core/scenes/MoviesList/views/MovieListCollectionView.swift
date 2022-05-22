//
//  MovieListCollectionView.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-22.
//

import UIKit
import Kingfisher
import RxSwift

class MovieListCollectionView: NibView {

    @IBOutlet private var label: UILabel!
    @IBOutlet private var listView: UICollectionView!
    @IBOutlet private var loader: UIActivityIndicatorView!
    
    private var favouritedID = PublishSubject<MovieViewModel>()
    var onFavouriteToggled: Observable<MovieViewModel> {
        favouritedID.asObservable()
    }
    
    private var onSelectPublisher = PublishSubject<MovieViewModel>()
    var onSelect: Observable<MovieViewModel> {
        onSelectPublisher.asObservable()
    }
    
    

    var viewModels = [MovieViewModel]() {
        didSet {
            listView.reloadData()
        }
    }
    
    
    
    @IBInspectable
    var title: String {
        set { label.text = newValue }
        get { label.text ?? "" }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        listView.register(MovieItemCollectionViewCell.self)
        listView.delegate = self
        listView.dataSource = self
    }
    
    func update(model: MovieViewModel) {
        if let index = viewModels.firstIndex(where: {$0.id == model.id}) {
            viewModels[index] = model
            listView.reloadItems(at: [IndexPath(row: index, section: 0)])
        }
    }
    
    func render(loading flag: Bool) {
        guard viewModels.isEmpty else {
            loader.stopAnimating()
            return
        }
        
        flag ? loader.startAnimating(): loader.stopAnimating()
    }
}


extension MovieListCollectionView: UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        onSelectPublisher.onNext(
            viewModels[indexPath.row]
        )
    }
    
}

extension MovieListCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeue(
            MovieItemCollectionViewCell.self, indexPath: indexPath
        )
        
        let viewModel = viewModels[indexPath.row]
        cell.imageView.kf.setImage(with: viewModel.image)
        cell.nameLabel.text = viewModel.name
        cell.ratingLabel.text = viewModel.rating
        
        if viewModel.isFavourite {
            cell.favouriteButton.setImage(R.Icon.heartFill, for: .normal)
        } else {
            cell.favouriteButton.setImage(R.Icon.heart, for: .normal)
        }
        
        cell.delegate = self
        
        // assign view model here
        
        return cell
    }
    
}

extension MovieListCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(
            width: collectionView.frame.size.width / 2,
            height: collectionView.frame.size.height
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        .init(top: 0, left: 20, bottom: 0, right: 20)
    }
    
}



extension MovieListCollectionView: MovieItemCollectionViewCellDelegate {
    
    func tappedFavourite(on cell: MovieItemCollectionViewCell) {
        guard let indexPath = listView.indexPath(for: cell)
        else { return }
        
        // Notify observer
        favouritedID.onNext(viewModels[indexPath.row])
    }
    
}
