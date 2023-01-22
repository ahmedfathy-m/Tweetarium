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
    
    func createLogOutAlert(coordinator: LogoutAlertCoordinator?) -> UIViewController {
        let viewController = LogoutAlertViewController()
        viewController.coordinator = coordinator
        return viewController
    }
    
    func createSuccessMessage(message: String) -> UIViewController {
        let viewController = SuccessMessageViewController()
        viewController.message = message
        return viewController
    }
}
