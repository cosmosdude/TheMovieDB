//
//  MovieListCoordinator.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-22.
//

import Foundation
import UIKit

class MovieListCoordinator: Coordinator {
    
    let window: UIWindow
    var navigationController: UINavigationController!
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        
        // Controller
        let sb = UIStoryboard(name: "MovieList", bundle: .main)
        guard let vc = sb.instantiateInitialViewController()
        else {
            fatalError("Unable to find the movie list controller")
        }
        let viewController = vc as? MovieListViewController
        let presenter = MovieListPresenter()
        let interactor = MovieListInteractor()
        
        viewController?.output = interactor
        interactor.output = presenter
        presenter.output = viewController
        
        viewController?.coordinator = self
        
        // configure object relation here
        
        navigationController = UINavigationController(
            rootViewController: vc
        )
        navigationController.delegate = self
        window.rootViewController = navigationController
    }
    
    func showDetail(id: Int) {
        
        let coordinator = MovieDetailCoordinator(
            navigationController: navigationController, movieID: id
        )
        
        add(child: coordinator)
        coordinator.start()
    }
    
}


extension MovieListCoordinator: UINavigationControllerDelegate {
    
    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        if viewController == navigationController.children.first {
            children = []
        }
    }
    
    
}
