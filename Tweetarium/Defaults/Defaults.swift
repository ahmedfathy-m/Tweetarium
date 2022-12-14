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
