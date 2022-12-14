//
//  LoadingViewController.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 26/11/2022.
//

import UIKit
import AuthenticationServices

class LoadingViewController: UIViewController {
    weak var coordinator: AuthCoordinator?
    // MARK: - @IBOutlets
    @IBOutlet weak var loadIcon: UIImageView!
    @IBOutlet weak var login: UIButton!
    
    // MARK: - View Model
    lazy var viewModel = LoadingViewModel { response in
        self.coordinator?.didSuccessfullyLogin()
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        login.layer.opacity = 0
        animateLoadingIcon()
        Task {
            await viewModel.fetchInitalOauthToken()
            stopAnimation()
            animateButton()
        }
    }
    
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
    
    // MARK: - IBActions
    @IBAction func didPressLogin(_ sender: UIButton) {
        viewModel.initAuthenticationSession(handler: self)
    }
}

extension LoadingViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window ?? ASPresentationAnchor()
    }
}
