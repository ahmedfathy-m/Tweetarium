//
//  Factory.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 16/01/2023.
//

import UIKit

class ViewControllerFactory {
    func buildTabBar(coordinator: TimelineCoordinator?) -> UITabBarController {
        // Create Tabbar
        let tabBarController = RootTabbarController()
        tabBarController.coordinator = coordinator
        
        // Create Header
        let customHeader = createHeader(delegate: tabBarController)
        tabBarController.customHeader = customHeader
        
        // Bar Content Frame
        let barSize = CGSize(width: UIViewController().view.safeAreaLayoutGuide.layoutFrame.width - 24,
                             height: UINavigationController().navigationBar.frame.height - UIViewController().view.safeAreaInsets.top)
        let barFrame = CGRect(origin: .zero, size: barSize)
        let someView = UIView(frame: barFrame)
        
        tabBarController.navigationItem.titleView = someView
        tabBarController.navigationItem.titleView?.translatesAutoresizingMaskIntoConstraints = false
        tabBarController.navigationItem.titleView?.addSubview(customHeader)
        
        // Constaints for custom header inside the title view
        NSLayoutConstraint.activate([
            someView.leadingAnchor.constraint(equalTo: customHeader.leadingAnchor),
            someView.trailingAnchor.constraint(equalTo: customHeader.trailingAnchor),
            someView.topAnchor.constraint(equalTo: customHeader.topAnchor),
            someView.bottomAnchor.constraint(equalTo: customHeader.bottomAnchor)
        ])
        customHeader.showTitle("Home"~) // Initial Value
        
        // Create Tabs
        let screenTypes: [TimelineType] = [.mentions, .home, .profile]
        let views: [TimelineViewController] = screenTypes.map { type in
            let viewController = TimelineViewController()
            viewController.coordinator = coordinator
            viewController.tabBarItem.title = type.title~
            viewController.tabBarItem.image = UIImage(systemName: type.itemImage)
            viewController.tabBarItem.selectedImage = UIImage(systemName: "\(type.itemImage).fill")
            viewController.viewModel = TimelineViewModel(type)
            viewController.rootController = tabBarController
            return viewController
        }
        
        // Assign Tabs
        tabBarController.setViewControllers(views, animated: true)
        tabBarController.selectedIndex = 1
        return tabBarController
    }
    
    func createHeader(delegate: TwitterHeaderDelegate?) -> TwitterHeaderProtocol {
        let nib = UINib(nibName: "TwitterUserHeader", bundle: nil)
        let view = nib.instantiate(withOwner: nil)[0] as! TwitterHeaderProtocol
        view.delegate = delegate
        view.translatesAutoresizingMaskIntoConstraints = false
        let width = UIViewController().view.safeAreaLayoutGuide.layoutFrame.width - 24
        let height = UINavigationController().navigationBar.frame.height - UIViewController().view.safeAreaInsets.top
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: width),
            view.heightAnchor.constraint(equalToConstant: height)
        ])
        return view
    }
    
    func createWarningAlert(coordinator: PreferncesCoordinator?) -> UIAlertController {
        let alert = UIAlertController(title: "Alert"~, message: "The application must restart for the changes to take effect."~, preferredStyle: .actionSheet)
        let exitAction = UIAlertAction(title: "Restart App"~, style: .default) { _ in
            coordinator?.reset()
            UIView.updateViewsDirection()
        }
        let laterAction = UIAlertAction(title: "Later"~, style: .destructive)
        alert.addAction(exitAction)
        alert.addAction(laterAction)
        return alert
    }
    
    func createLogOutAlert(coordinator: PreferncesCoordinator?) -> UIAlertController {
        let alert = UIAlertController(title: "Alert"~, message: "Are you certain you want to log out of Tweetarium?"~, preferredStyle: .actionSheet)
        let logout = UIAlertAction(title: "Logout"~, style: .destructive) { _ in
            coordinator?.logout()
        }
        let laterAction = UIAlertAction(title: "Cancel"~, style: .default)
        alert.addAction(logout)
        alert.addAction(laterAction)
        return alert
    }
}
