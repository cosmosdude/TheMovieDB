//
//  PersistanceConfiguration.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-21.
//

import Foundation

enum PersistanceConfiguration {
    
    static func configure() {
        MoviesPersistanceManager.shared = .init(DefaultRealmFactory())
        
//        MoviesPersistanceManager.shared.realm
//            .deleteAll()
    }
    
}
