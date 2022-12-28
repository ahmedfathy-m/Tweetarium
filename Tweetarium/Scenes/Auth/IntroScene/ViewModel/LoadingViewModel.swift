//
//  LoadingViewModel.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 26/11/2022.
//

import Foundation
import AuthenticationServices

class LoadingViewModel {
    var oAuthToken: String?
    var oAuthTokenSecret: String?
    var callbackConfirmed: Bool?
    
    var onSuccessfulLogin: (String)->()
    
    init(onSuccessfulLogin: @escaping (String) -> Void) {
        self.onSuccessfulLogin = onSuccessfulLogin
    }
    
    // MARK: - Intents
    
    // 1. INITIAL LOADING
    func fetchInitalOauthToken(handler: ActivityHandler? = nil) async {
        clearTemporaryTokens()
        guard let response = await NetworkService.shared.fetchText(from: OAuth.requestToken(""), handler: handler) else { return }
        let components = response.components(separatedBy: "&")
        let temporaryAccessToken = components[0].components(separatedBy: "=")[1]
        let temporaryAccessTokenSecret = components[1].components(separatedBy: "=")[1]
        Defaults.accessToken.setValue(temporaryAccessToken)
        Defaults.accessTokenSecret.setValue(temporaryAccessTokenSecret)
    }
    
    func clearTemporaryTokens() {
        let value: String? = nil
        Defaults.accessToken.setValue(value)
        Defaults.accessTokenSecret.setValue(value)
    }
    
    // 2. SIGN IN PRESSED
    func initAuthenticationSession(handler: ASWebAuthenticationPresentationContextProviding){
        let token = Defaults.accessToken.value as! String
        let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(token)")!
        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: "tweetarium") { callback, error in
            guard error == nil, let callback = callback else { return }
            let callbackWithComponents = URLComponents(url: callback, resolvingAgainstBaseURL: true)
            let queryItems = callbackWithComponents?.queryItems
            if let verifier = queryItems?[1].value {
                Defaults.oauthVerifier.setValue(verifier)
                let route = OAuth.accessToken
                Task {
                    guard let response = await NetworkService.shared.fetchText(from: route) else { return }
                    let responseComponents = response.components(separatedBy: "&").map({$0.components(separatedBy: "=")[1]})
                    Defaults.accessToken.setValue(responseComponents[0])
                    Defaults.accessTokenSecret.setValue(responseComponents[1])
                    Defaults.userID.setValue(responseComponents[2])
                    let screenName = responseComponents[3]
                    print("Welcome, \(screenName)")
                    DispatchQueue.main.async { self.onSuccessfulLogin(screenName) }
                }
            }
        }
        session.presentationContextProvider = handler
        session.start()
    }
}
