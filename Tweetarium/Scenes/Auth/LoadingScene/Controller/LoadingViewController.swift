//
//  LoadingViewController.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 26/11/2022.
//

import UIKit

class LoadingViewController: UIViewController {
    // MARK: - @IBOutlets
    @IBOutlet weak var loadIcon: UIImageView!
    
    // MARK: - View Model
    let viewModel = LoadingViewModel { response in
        print(response)
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        animateLoadingIcon()
        Task {
            await viewModel.fetchInitalOauthToken()
            stopAnimation()
        }
    }
    
    func animateLoadingIcon() {
        loadIcon.image = loadIcon.image?.withTintColor(UIColor(named: "main")!, renderingMode: .alwaysTemplate)
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .repeat) {
            let repeats = 4
            let frameDuration = 1.0 / Double(repeats)
            for i in 0..<repeats {
                let relativeStartTime = Double(i) / Double(repeats)
                UIView.addKeyframe(withRelativeStartTime: relativeStartTime, relativeDuration: frameDuration) {
                    let angle = CGFloat.pi / 2 * CGFloat(i + 1)
                    self.loadIcon.transform = CGAffineTransform(rotationAngle: angle)
                }
            }
        }
    }
    
    func stopAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.loadIcon.layer.opacity = 0
        }
    }
}
