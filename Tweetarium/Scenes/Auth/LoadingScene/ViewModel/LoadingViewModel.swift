//
//  LoadingViewModel.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 26/11/2022.
//

import Foundation

class LoadingViewModel {
    var oAuthToken: String?
    var oAuthTokenSecret: String?
    var callbackConfirmed: Bool?
    
    var bind: (String)->()
    
    init(bind: @escaping (String) -> Void) {
        self.bind = bind
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
        Defaults.accessToken.setValue(nil)
        Defaults.accessTokenSecret.setValue(nil)
    }
}
