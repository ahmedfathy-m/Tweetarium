//
//  SuccessMessageViewController.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 22/01/2023.
//

import UIKit

class SuccessMessageViewController: AFViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var messageLabel: UILabel!
    
    // MARK: - Data
    var message: String!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMessage()
    }
    
    // MARK: - Configure Message
    private func configureMessage() {
        self.messageLabel.text = message
    }
    
    // MARK: - Actions
    @IBAction func didPressOkay(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
