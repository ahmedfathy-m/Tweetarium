//
//  TweetObjectView+Instntiation.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 15/01/2023.
//

import UIKit

extension TweetObjectView {
    // MARK: - Nib
    static private var identifier: String {
        return String(describing: self)
    }
    
    static private func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: .main)
    }
    
    // MARK: - Register Nib
    static func registerFor(_ tableView: UITableView) {
        tableView.register(TweetObjectView.nib(), forCellReuseIdentifier: TweetObjectView.identifier)
    }
}
