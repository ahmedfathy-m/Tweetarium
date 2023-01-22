//
//  LogoutAlertViewController.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 22/01/2023.
//

import UIKit

class LogoutAlertViewController: AFViewController {
    // MARK: - Coordinator
    weak var coordinator: LogoutAlertCoordinator?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func didPressCancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didPressConfirm(_ sender: Any) {
        self.dismiss(animated: true) {
            self.coordinator?.logout()
        }
    }
    
}
