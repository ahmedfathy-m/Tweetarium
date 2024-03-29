//
//  AcitivityHandler.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 13/12/2022.
//

import Foundation
import AuthenticationServices

protocol ActivityHandler: LoadingHandler, MessageHandler {
    func shouldDismiss()
}

protocol AuthenticationHandler: ASWebAuthenticationPresentationContextProviding, ActivityHandler {}

protocol LoadingHandler {
    func initLoader()
    func deinitLoader()
}

protocol MessageHandler {
    func present(_ error: String, retry: () async ->() )
    func present(_ message: String, type: MessageType)
}

enum MessageType {
    case error
    case success
    case info
}
