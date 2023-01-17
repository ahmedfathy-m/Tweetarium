//
//  LoadingViewController+Animations.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 17/01/2023.
//

import UIKit

extension LoadingViewController {
    // MARK: - UI Configuration
    func animateLoadingIcon() {
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

    func animateButton() {
        UIView.animate(withDuration: 1, delay: 0) {
            self.login.layer.opacity = 1
        }
    }

}
