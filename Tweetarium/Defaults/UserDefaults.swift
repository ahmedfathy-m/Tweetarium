//
//  Defaults.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 13/12/2022.
//

import Foundation

extension UserDefaults {
    var isDarkModeEnabled: Bool {
        get { return UserDefaults.standard.bool(forKey: "IsDarkModeEnabled") }
        set { UserDefaults.standard.set(newValue, forKey: "IsDarkModeEnabled") }
    }
    
    var currentLanguage: Language {
        let langs = UserDefaults.standard.object(forKey: "AppleLanguages") as! NSArray
        if langs.firstObject as! String == "ar" {
            return .arabic
        } else {
            return .english
        }
    }
    
    func setLanguage(_ lang: Language) {
        UserDefaults.standard.set([lang.key, currentLanguage.key], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
    
    var credentials: Credentials? {
        get {
            guard let token = self.accessToken, let secret = self.accessTokenSecret else { return nil }
            return Credentials(token: token, secret: secret)
        }
        set {
            accessToken = newValue?.token
            accessTokenSecret = newValue?.secret
        }
    }
    
    var oauthVerifier: String? {
        get { UserDefaults.standard.string(forKey: "oauthVerifier") }
        set { UserDefaults.standard.set(newValue, forKey: "oauthVerifier") }
    }
    
    private var accessToken: String? {
        get { UserDefaults.standard.string(forKey: "accessToken") }
        set { UserDefaults.standard.set(newValue, forKey: "accessToken") }
    }
    
    private var accessTokenSecret: String? {
        get { UserDefaults.standard.string(forKey: "accessTokenSecret") }
        set { UserDefaults.standard.set(newValue, forKey: "accessTokenSecret") }
    }
    
    var userID: String? {
        get { UserDefaults.standard.string(forKey: "userID") }
        set { UserDefaults.standard.set(newValue, forKey: "userID") }
    }
    
    func removeAll() {
        isDarkModeEnabled = false
        accessToken = nil
        accessTokenSecret = nil
        userID = nil
        setLanguage(.english)
    }
}
