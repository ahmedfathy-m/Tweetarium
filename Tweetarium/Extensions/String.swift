//
//  String.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 26/11/2022.
//

import Foundation

extension String {
    func percentEncoded() -> Self {
        let charSet = CharacterSet(charactersIn: "01234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0-._~")
        return self.addingPercentEncoding(withAllowedCharacters: charSet)!
    }
}
