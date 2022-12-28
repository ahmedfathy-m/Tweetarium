//
//  RootTabbarController.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 27/12/2022.
//

import UIKit

class RootTabbarController: UITabBarController {
    lazy var customHeader = TwitterUserHeader.instantiateWithWidth(view.frame.width)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - Navigation Bar
        let newTitleView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: 50)))
        self.navigationItem.titleView = newTitleView
        newTitleView.addSubview(customHeader)
        
        // MARK: - Sub-ViewControllers
        let screenTypes: [TimelineType] = [.mentions, .home, .profile]
        let views: [TimelineViewController] = screenTypes.map { type in
            let viewController = TimelineViewController()
            viewController.configureTitles(type)
            return viewController
        }
        self.setViewControllers(views, animated: true)
        self.selectedIndex = 1
        customHeader.configure(with: (self.selectedViewController as! TimelineViewController).screenType)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item) else { return }
        let viewController = self.viewControllers?[index] as! TimelineViewController
        customHeader.configure(with: viewController.screenType)
        guard !(self.selectedViewController as! TimelineViewController).tweetsTable.visibleCells.isEmpty else { return }
        (self.selectedViewController as! TimelineViewController).tweetsTable.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}
