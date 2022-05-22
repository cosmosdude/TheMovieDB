//
//  Reachability+Notifications.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-22.
//

import Foundation

enum ReachabilityEvent {
    static let reachable = Notification.Name(
        rawValue: "Reachability.reachable"
    )
}
