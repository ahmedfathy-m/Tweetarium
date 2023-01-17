//
//  Defaults.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 13/12/2022.
//

import Foundation

enum Defaults: String, CaseIterable {
    case accessToken
    case accessTokenSecret
    case oauthVerifier
    case userID
}

extension Defaults {
    var value: Any? {
        get { return UserDefaults.standard.value(forKey: self.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: self.rawValue) }
    }
    
    func setValue<T>(_ value: T?) {
        UserDefaults.standard.set(value, forKey: self.rawValue)
    }
}

extension UserDefaults {
    var isDarkModeEnabled: Bool {
        get { return UserDefaults.standard.bool(forKey: "IsDarkModeEnabled") }
        set { UserDefaults.standard.set(newValue, forKey: "IsDarkModeEnabled") }
    }
    
    var tweetariumLanguage: String? {
        get { return UserDefaults.standard.string(forKey: "TweetariumLanguage") }
        set { UserDefaults.standard.set(newValue, forKey: "TweetariumLanguage") }
    }
    
    var currentLanguage: String {
        let langs = UserDefaults.standard.object(forKey: "AppleLanguages") as! NSArray
        return langs.firstObject as! String
    }
    
    func setLanguage(_ lang: String) {
        UserDefaults.standard.set([lang, currentLanguage], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
    
    var accessToken: String? {
        get { UserDefaults.standard.string(forKey: "accessToken") }
        set { UserDefaults.standard.set(newValue, forKey: "accessToken") }
    }
    
    var accessTokenSecret: String? {
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
        setLanguage("en")
    }
}
