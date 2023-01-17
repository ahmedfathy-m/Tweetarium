//
//  TweetObjectView+UIConfiguration.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 15/01/2023.
//

import UIKit

extension TweetObjectView {
    func initialUIConfiguration() {
        // Initialization code
        avatarOfOriginalAuthor.layer.cornerRadius = avatarOfOriginalAuthor.frame.height / 2
        avatarOfOriginalAuthor.kf.indicatorType = .activity
        tweetMediaGallery.dataSource = self
        tweetMediaGallery.delegate = self
        TweetMediaEntityView.register(for: tweetMediaGallery)
        tweetMediaGallery.layer.cornerRadius = 10
        tweetMediaGallery.clipsToBounds = true
        likeButton.imageView?.contentMode = .scaleAspectFit
        retweetButton.imageView?.contentMode = .scaleAspectFit
        
        viewOfQuotedStatus.layer.borderColor = UIColor.systemGray3.cgColor
        viewOfQuotedStatus.layer.borderWidth = 0.5
        viewOfQuotedStatus.layer.cornerRadius = 10
        avatarOfQuotedStatusAuthor.layer.cornerRadius = avatarOfQuotedStatusAuthor.frame.width / 2
        mediaEntityOfQuotedStatus.layer.cornerRadius = 5
        mediaEntityOfQuotedStatus.kf.indicatorType = .activity
        mediaEntityOfQuotedStatus.isHidden = true
        textOfOriginalTweet.textContainerInset = .zero
        textOfOriginalTweet.textContainer.lineFragmentPadding = .zero
        textOfOriginalTweet.delegate = self
        
        pageControlOfTweetGallery.backgroundStyle = .minimal
        pageControlOfTweetGallery.allowsContinuousInteraction = false
        enclosingViewOfPageControl.layer.cornerRadius = enclosingViewOfPageControl.frame.height / 2
        enclosingViewOfPageControl.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        enclosingViewOfPageControl.insertSubview(blurView, at: 0)
        enclosingViewOfPageControl.clipsToBounds = true
        
        
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
        blurView.contentView.insertSubview(vibrancyView, at: 1)
        
        NSLayoutConstraint.activate([
            blurView.leadingAnchor.constraint(equalTo: enclosingViewOfPageControl.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: enclosingViewOfPageControl.trailingAnchor),
            blurView.topAnchor.constraint(equalTo: enclosingViewOfPageControl.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: enclosingViewOfPageControl.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            vibrancyView.leadingAnchor.constraint(equalTo: blurView.contentView.leadingAnchor),
            vibrancyView.trailingAnchor.constraint(equalTo: blurView.contentView.trailingAnchor),
            vibrancyView.topAnchor.constraint(equalTo: blurView.contentView.topAnchor),
            vibrancyView.bottomAnchor.constraint(equalTo: blurView.contentView.bottomAnchor)
        ])
    }
    
    func configureUIMenu() {
        retweetButton.showsMenuAsPrimaryAction = true
        let retweet = UIAction(title: "Retweet"~, image: UIImage(systemName: "arrow.2.squarepath")) { action in
            self.didPressRetweet()
        }
        let quote = UIAction(title: "Quote Retweet"~, image: UIImage(systemName: "pencil")) { _ in
            self.didPressQuote()
        }
        retweetButton.menu = UIMenu(title: "Retweet"~, children: [retweet, quote])
    }
}
