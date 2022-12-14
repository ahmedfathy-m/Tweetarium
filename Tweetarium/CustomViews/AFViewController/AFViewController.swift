//
//  AFViewController.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 13/12/2022.
//

import UIKit

class AFViewController: UIViewController {

    @IBInspectable var tabViewImage: UIImage {
        get { self.tabBarItem.image ?? UIImage() }
        set { self.tabBarItem.image = newValue }
    }
    
    @IBInspectable var selectedTabViewImage: UIImage {
        get { self.tabBarItem.selectedImage ?? UIImage() }
        set { self.tabBarItem.selectedImage = newValue }
    }

    @IBInspectable var tabViewTitle: String {
        get { self.tabBarItem.title ?? String() }
        set { self.tabBarItem.title = newValue }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AFViewController: ActivityHandler {
    func initLoader() {
        print("Start")
    }
    
    func deinitLoader() {
        print("Ended")
    }
    
    func present(_ error: String, retry: () async -> ()) {
        print(error)
    }
    
    func present(_ message: String, type: MessageType) {
        print(message)
    }
    
    
}
