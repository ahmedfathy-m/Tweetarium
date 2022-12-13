//
//  RequestSigner.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 26/11/2022.
//

import Foundation
import CryptoSwift

class OAuthRequestSigner {
    // 1. CONSTANTS
    let route: NetworkingRoute
    let oauthVersion = "1.0"
    let method = "HMAC-SHA1"
    let clientKey: String
    let clientSecret: String
    let oauthToken: String?
    let oauthTokenSecret: String?
    
    let timestamp = String(Int64(Date().timeIntervalSince1970))
    let nonce = UUID().uuidString.prefix(8).description
    
    // 2. INITIALIZER
    init(route: NetworkingRoute, clientKey: String, clientSecret: String, oauthToken: String? = nil, oauthTokenSecret: String? = nil) {
        self.route = route
        self.clientKey = clientKey
        self.clientSecret = clientSecret
        self.oauthToken = oauthToken
        self.oauthTokenSecret = oauthTokenSecret
    }
    
    // 2. SIGNATURE BASE STRING
    private func buildBaseString() -> String {
        let additionalParams = route.defaultQueryParameters
        var auth: [String: String] = [
            "oauth_consumer_key": clientKey,
            "oauth_signature_method": method,
            "oauth_timestamp": self.timestamp,
            "oauth_nonce": self.nonce,
            "oauth_version": oauthVersion
        ]
        
        if let oauthToken = oauthToken {
            auth["oauth_token"] = oauthToken
        }
        
        // OAuth requires each key-value pair to be percent encoded and joined by a '='
        var authComponents = auth.map({ "\($0.key.percentEncoded())=\($0.value.percentEncoded())" })
        let additionalComponents = additionalParams.map({ "\($0.key.percentEncoded())=\($0.value.percentEncoded())" })
        authComponents.append(contentsOf: additionalComponents)
        
        authComponents.sort() // OAuth requires entries to be sorted alphabetically
        let parameterString = authComponents.joined(separator: "&") // All entries joinde by '&' as per OAuth1.0 Requirements
        
        let signatureBaseString = "\(route.defaultMethod.rawValue)&\(route.targetURL.percentEncoded())&\(parameterString.percentEncoded())"
        print(signatureBaseString)
        return signatureBaseString
    }
    
    // 3. SIGNATURE KEY
    private func buildSignatureKey() -> String {
        var signatureKey = [clientSecret]
        if let oauthTokenSecret = oauthTokenSecret {
            signatureKey.append(oauthTokenSecret)
            return signatureKey.joined(separator: "&")
        } else {
            return "\(signatureKey[0])&"
        }
        
    }
    
    // 4. SIGNATURE
    private func buildSignature() -> String {
        let message = buildBaseString().bytes
        let key = buildSignatureKey()
        let hmac = try! HMAC(key: key, variant: .sha1)
        let signature = try! hmac.authenticate(message).toBase64()
        return signature
    }
    
    // 5. AUTHORIZATION HEADER
    func buildAuthHeader() -> String {
        let signature = buildSignature()
        let auth: [String: String] = [
            "oauth_consumer_key": clientKey,
            "oauth_signature_method": method,
            "oauth_timestamp": self.timestamp,
            "oauth_nonce": self.nonce,
            "oauth_version": oauthVersion,
            "oauth_signature": signature
        ]
        var authHeader = auth.map({ "\($0.key.percentEncoded())=\($0.value.percentEncoded())" }).sorted().joined(separator: ",")
        authHeader = "OAuth \(authHeader)"
        return authHeader
    }
    
    // 6. SIGNED OAUTH REQUEST
    func sign(request: URLRequest) -> URLRequest {
        let header = buildAuthHeader()
        var signedRequest = request
        print(header)
        signedRequest.addValue(header, forHTTPHeaderField: "Authorization")
        return signedRequest
    }
}
