//
//  TwitterUserHeader.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 27/12/2022.
//

import UIKit
import Kingfisher

class TwitterUserHeader: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var numberOfTweets: UILabel!
    var screenName: String = "Username"
    var tweetCount: Int = 0 {
        didSet { numberOfTweets.text = "\(tweetCount) Tweets" }
    }
    
    override func awakeFromNib() {
        imageView.layer.cornerRadius = imageView.frame.width / 2.0
        imageView.kf.indicatorType = .activity
    }
    
    func configure(with screenType: TimelineType?) {
        switch screenType {
        case .home, .mentions:
            titleLabel.text = screenType?.title
            numberOfTweets.isHidden = true
        case .profile:
            titleLabel.text = screenName
            numberOfTweets.isHidden = false
        case .none:
            titleLabel.text = "Tweetarium"
            numberOfTweets.isHidden = true
        }
    }
    
    static func instantiateFromNib() -> TwitterUserHeader {
        let nib = UINib(nibName: "TwitterUserHeader", bundle: nil)
        let view = nib.instantiate(withOwner: nil)[0] as! TwitterUserHeader
        return view
    }
    
    static func instantiateWithWidth(_ width: CGFloat) -> TwitterUserHeader {
        let view = TwitterUserHeader.instantiateFromNib()
        let height = UINavigationController().navigationBar.frame.height - UIViewController().view.safeAreaInsets.top
        view.frame = CGRect(origin: view.frame.origin,
                            size: CGSize(width: width, height: height))
        return view
    }
}
