//
//  NetworkConfiguration.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-21.
//

import Foundation
import Alamofire
import Reachability

enum NetworkConfiguration {
    
    static func config() {
        MovieApiRepository.shared = .init(
            domain: "https://api.themoviedb.org/3",
            apikey: "651c3ad22c68083e006201fb1bd232d8"
        )
            
        AF.sessionConfiguration.urlCache = nil
        
        try! Reachability.network.startNotifier()
        Reachability.network.whenReachable = { reachability in
            NotificationCenter.default
                .post(name: ReachabilityEvent.reachable, object: nil)
        }
    }
    
}
