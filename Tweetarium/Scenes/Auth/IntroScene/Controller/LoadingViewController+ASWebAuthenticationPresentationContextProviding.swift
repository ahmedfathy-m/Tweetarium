//
//  LoadingViewController+ASWebAuthenticationPresentationContextProviding.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 17/01/2023.
//

import Foundation
import AuthenticationServices

extension LoadingViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window ?? ASPresentationAnchor()
    }
}
