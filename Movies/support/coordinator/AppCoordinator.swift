//
//  AppCoordinator.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-22.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    static var shared: AppCoordinator!
    
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let coordinator = MovieListCoordinator(window: window)
        add(child: coordinator)
        coordinator.start()
    }
}
