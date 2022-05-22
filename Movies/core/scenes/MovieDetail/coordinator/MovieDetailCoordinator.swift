//
//  MovieDetailCoordinator.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-22.
//

import Foundation
import UIKit

class MovieDetailCoordinator: Coordinator {
    
    var navigation: UINavigationController
    var id: Int
    
    init(navigationController: UINavigationController, movieID: Int) {
        self.navigation = navigationController
        id = movieID
    }
    
    override func start() {
        
        // Controller
        let sb = UIStoryboard(name: "MovieDetail", bundle: .main)
        guard let vc = sb.instantiateInitialViewController()
        else {
            fatalError("Unable to find the movie list controller")
        }

        let view = vc as? MovieDetailViewProtocol
        let interactor = MovieDetailInteractor(movieId: id)
        let presenter = MovieDetailPresenter()
        
        view?.output = interactor
        interactor.output = presenter
        presenter.output = view
    
        let viewController = vc as? MovieDetailViewController
        viewController?.coordinator = self
        navigation.pushViewController(vc, animated: true)
    }
}
