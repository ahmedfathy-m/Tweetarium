//
//  Client.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 20/01/2023.
//

import Foundation

struct Client {
    static let shared = Client()
    private init() {}
    
    let key = APIKeys.key
    let secret = APIKeys.secret
}
