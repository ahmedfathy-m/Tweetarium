//
//  AFViewController.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 13/12/2022.
//

import UIKit

class AFViewController: UIViewController {
    
    fileprivate lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()

    var activityLoader: AFLoadingIndicator = AFLoadingIndicator(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension AFViewController: ActivityHandler {
    func initLoader() {
        DispatchQueue.main.async {
            self.view.bringSubviewToFront(self.indicator)
            self.indicator.isHidden = false
            self.indicator.startAnimating()
        }
        print("Start")
    }
    
    func deinitLoader() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
        }
    }
    
    func present(_ error: String, retry: () async -> ()) {
        let alert = UIAlertController(title: "ERROR", message: error, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
        print(error)
    }
    
    func present(_ message: String, type: MessageType) {
        let alert = UIAlertController(title: "ERROR", message: message, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
        print(message)
    }
    
    
}
