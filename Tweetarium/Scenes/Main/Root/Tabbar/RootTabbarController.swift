//
//  RootTabbarController.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 27/12/2022.
//

import UIKit

class RootTabbarController: UITabBarController {
//    lazy var customHeader = TwitterUserHeader.instantiateWithWidth(view.frame.width)
    var customHeader: TwitterUserHeader!
    weak var coordinator: TimelineCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // MARK: - Navigation Bar
        let newTitleView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: 50)))
        self.navigationItem.titleView = newTitleView
        newTitleView.addSubview(customHeader)
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


extension RootTabbarController: TwitterHeaderDelegate {
    func didRequestPresentationOfPreferences() {
        coordinator?.shouldNavigateToSettings()
    }
}
