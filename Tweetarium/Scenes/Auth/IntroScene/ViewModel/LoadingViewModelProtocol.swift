//
//  LoadingViewModelProtocol.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 17/01/2023.
//

import Foundation
import AuthenticationServices

protocol LoadingViewModelProtocol {
    var didSuccessfullyLogin: Observable<Bool> {get set}
    var didFetchInitialToken: Observable<Bool> {get set}
    func fetchInitalOauthToken()
    func initAuthenticationSession(handler: ASWebAuthenticationPresentationContextProviding)
}
