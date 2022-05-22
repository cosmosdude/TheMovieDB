//
//  Coordinator.swift
//  Movies
//
//  Created by Thwin Htoo Aung on 2022-05-22.
//

import Foundation

protocol CoordinatorProtocol: AnyObject {
    
    var parent: CoordinatorProtocol? { get set }
    var children: [CoordinatorProtocol] { get }
    
    func start()
}


class Coordinator: NSObject, CoordinatorProtocol {
    
    weak var parent: CoordinatorProtocol?
    var children: [CoordinatorProtocol] = []
    
    func add(child: CoordinatorProtocol) {
        child.parent = self
        children.append(child)
    }
    
    func remove(child: CoordinatorProtocol) {
        if child.parent !== self { return }
        children.removeAll{$0 === child}
    }
    
    func start() { }
    
}
