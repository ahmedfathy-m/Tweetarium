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
    var viewModel: LoadingViewModelProtocol!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        login.layer.opacity = 0
        bindAuthAction()
        animateLoadingIcon()
        viewModel.fetchInitalOauthToken()
    }
    
    // MARK: - IBActions
    @IBAction func didPressLogin(_ sender: UIButton) {
        viewModel.initAuthenticationSession(handler: self)
    }
}
