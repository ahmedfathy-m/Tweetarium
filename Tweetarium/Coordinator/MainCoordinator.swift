//
//  MainCoordinator.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 26/11/2022.
//

import UIKit

class MainCoordinator: Coordinator {
    // 1. INITIALIZER
    init(navigation: UINavigationController, parent: Coordinator? = nil) {
        self.navigationController = navigation
        self.parentCoordinator = parent
    }
    
    // 2. COORDINATOR PROTOCOL
    var parentCoordinator: Coordinator?
    var childCoordinators: [String : Coordinator] = [:]
    var navigationController: UINavigationController
    
    func start() {
        let tabView = UITabBarController()
        let tab1 = MentionsViewController()
        let tab2 = TimelineViewController()
        let tab3 = ProfileViewController()
        tab1.view.backgroundColor = .systemBlue
        tab1.loadView()
        tab3.view.backgroundColor = .darkGray
        let views = [tab1, tab2, tab3]
//        views.forEach({$0.loadView()})
        tabView.setViewControllers(views, animated: true)
        navigationController.setViewControllers([tabView], animated: true)
    }
}
