//
//  RealmFactory.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-22.
//

import Foundation
import RealmSwift

protocol RealmFactory {
    
    func realm() -> Realm
    
}

class DefaultRealmFactory: RealmFactory {
    
    // Make more realm configurations later
    
    let configuration: Realm.Configuration = Realm.Configuration.defaultConfiguration
    
    func realm() -> Realm {
        try! Realm(configuration: configuration)
    }
    
}
