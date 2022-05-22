//
//  MoviesPersistanceManager.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-21.
//

import Foundation
import RealmSwift


class MoviesPersistanceManager {
    
    private var realmFactory: RealmFactory
    
    static var shared: MoviesPersistanceManager!
    
    init(_ realmFactory: RealmFactory) {
        self.realmFactory = realmFactory
    }
    
    var realm: Realm { realmFactory.realm() }
    
    func deleteAll() {
        
        try! realm.write {
            realm.deleteAll()
        }
    }
    
}


