//
//  LoadingViewModel.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 26/11/2022.
//

import Foundation
import AuthenticationServices

class LoadingViewModel: LoadingViewModelProtocol {
    // MARK: - Observables
    var didSuccessfullyLogin: Observable<Bool> = Observable(nil)
    var didFetchInitialToken: Observable<Bool> = Observable(nil)
    
    // MARK: - Intents
    // 1. INITIAL LOADING
    func fetchInitalOauthToken() {
        Task {
            clearTemporaryTokens()
            guard let response = await NetworkService.shared.fetchText(from: OAuth.requestToken("")) else { return }
            let components = response.components(separatedBy: "&")
            let temporaryAccessToken = components[0].components(separatedBy: "=")[1]
            let temporaryAccessTokenSecret = components[1].components(separatedBy: "=")[1]
            UserDefaults.standard.credentials = Credentials(token: temporaryAccessToken, secret: temporaryAccessTokenSecret)
            didFetchInitialToken.value = true
        }
    }
    
    private func clearTemporaryTokens() {
        UserDefaults.standard.credentials = nil
    }
    
    // 2. SIGN IN PRESSED
    func initAuthenticationSession(handler: ASWebAuthenticationPresentationContextProviding){
        guard let token = UserDefaults.standard.credentials?.token else { return }
        let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(token)")!
        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: "tweetarium") { callback, error in
            guard error == nil, let callback = callback else { return }
            let callbackWithComponents = URLComponents(url: callback, resolvingAgainstBaseURL: true)
            let queryItems = callbackWithComponents?.queryItems
            if let verifier = queryItems?[1].value {
                UserDefaults.standard.oauthVerifier = verifier
                let route = OAuth.accessToken
                Task {
                    guard let response = await NetworkService.shared.fetchText(from: route) else { return }
                    let responseComponents = response.components(separatedBy: "&").map({$0.components(separatedBy: "=")[1]})
                    UserDefaults.standard.credentials = Credentials(token: responseComponents[0], secret: responseComponents[1])
                    UserDefaults.standard.userID = responseComponents[2]
                    let screenName = responseComponents[3]
                    print("Welcome, \(screenName)")
                    self.didSuccessfullyLogin.value = true
                }
            }
        }
        session.presentationContextProvider = handler
        session.start()
    }
}
