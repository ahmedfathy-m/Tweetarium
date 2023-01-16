//
//  TwitterHeaderProtocol.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 16/01/2023.
//

import UIKit

protocol TwitterHeaderProtocol: UIView {
    func showUserInfo(name: String, count: Int, image: URL?)
    func showTitle(_ value: String)
    var delegate: TwitterHeaderDelegate? { get set }
}
