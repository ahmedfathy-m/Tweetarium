//
//  Coordinator.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 26/11/2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? {get set}
    var childCoordinators: [String :Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    func start()
    func removeCoordinator(with identifier: String)
}

extension Coordinator {
    func removeCoordinator(with identifier: String) {
        childCoordinators.removeValue(forKey: identifier)
    }
}
