//
//  MovieDAO.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-21.
//

import Foundation
import RealmSwift

class MovieDAO: Object {
    
    @Persisted var id: Int
    @Persisted var title: String
    @Persisted var overview: String
    @Persisted var posterURL: String
    @Persisted var backdropURL: String
    @Persisted var favourite: Bool
    @Persisted var rating: Double
    
    // Upcoming or Popular
    @Persisted var types: MutableSet<String>
    
    override class func primaryKey() -> String? { "id" }
}
