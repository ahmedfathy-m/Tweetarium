//
//  LoadingViewController+Binding.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 17/01/2023.
//

import Foundation

extension LoadingViewController {
    func bindAuthAction() {
        viewModel.didSuccessfullyLogin.bind { success in
            guard success == true else { return }
            self.coordinator?.didSuccessfullyLogin()
        }
        
        viewModel.didFetchInitialToken.bind { success in
            guard success == true else { return }
            self.stopAnimation()
            self.animateButton()
        }
    }
}
