//
//  TwitterUserHeader.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 27/12/2022.
//

import UIKit
import Kingfisher

class TwitterUserHeader: UIView {
    // MARK: - IBIOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var numberOfTweets: UILabel!
    
    // MARK: - Data
    var screenName: String = "Username"
    var tweetCount: Int = 0 {
        didSet { numberOfTweets.text = "\(tweetCount) Tweets" }
    }
    
    // MARK: - Delegate
    weak var delegate: TwitterHeaderDelegate?
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        makeCircularImage()
    }
    
    // MARK: - IBActions
    @IBAction func didPressSettings(_ sender: UIButton) {
        delegate?.didRequestPresentationOfPreferences()
    }
}
