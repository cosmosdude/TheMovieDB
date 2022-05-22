//
//  MovieItemCollectionViewCell.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-22.
//

import UIKit

class MovieItemCollectionViewCell: NibCollectionViewCell {
    
    @IBOutlet private(set) var imageView: UIImageView!
    @IBOutlet private(set) var nameLabel: UILabel!
    @IBOutlet private(set) var favouriteButton: UIButton!
    @IBOutlet private(set) var ratingLabel: UILabel!
    
    weak var delegate: MovieItemCollectionViewCellDelegate?
}


extension MovieItemCollectionViewCell {
    
    @IBAction private func actionWhenHeartIsPressed(button: UIButton!) {
        delegate?.tappedFavourite(on: self)
    }
    
}

protocol MovieItemCollectionViewCellDelegate: AnyObject {
    
    func tappedFavourite(on cell: MovieItemCollectionViewCell)
    
}
