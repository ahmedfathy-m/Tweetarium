//
//  TweetViewProtocol.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 15/01/2023.
//

import UIKit

protocol TweetViewProtocol: UITableViewCell {
    func formatCell(with viewModel: TweetViewModel)
    var delegate: TweetObjectDelegate? { get set }
}
