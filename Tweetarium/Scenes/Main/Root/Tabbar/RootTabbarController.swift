//
//  RootTabbarController.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 27/12/2022.
//

import UIKit

class RootTabbarController: UITabBarController {
    // MARK: - Header
    var customHeader: TwitterHeaderProtocol!
    
    // MARK: - User Info
    var user: UserObject?
    
    // MARK: - Coordinator
    weak var coordinator: TimelineCoordinator?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item) else { return }
        switch index {
            case 0:
                customHeader.showTitle("Mentions")
            case 1:
                customHeader.showTitle("Home")
            case 2:
                guard let user = user else { return }
            customHeader.showUserInfo(name: user.name, count: user.tweetsCount, image: user.profileImage)
            default:
                break
        }
    }
}
