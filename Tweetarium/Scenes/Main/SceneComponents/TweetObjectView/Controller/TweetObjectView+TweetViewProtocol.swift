//
//  TweetObjectView+TweetViewProtocol.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 15/01/2023.
//

import UIKit

extension TweetObjectView: TweetViewProtocol {
    func formatCell(with viewModel: TweetViewModel) {
        self.viewModel = viewModel
        self.bindLikeStatus()
        self.bindRetweetStatus()
        self.tweetID = Int(viewModel.model.id)
        self.nameOfOriginalAuthor.text = viewModel.displayName
        self.handleOfOriginalAuthor.text = viewModel.displayHandle
        self.timeSincePosting.text = "• \(viewModel.postedSince)"
        self.contentOfOriginalTweet.attributedText = viewModel.displayText
        self.textOfOriginalTweet.attributedText = viewModel.displayText
        self.contentOfOriginalTweet.textAlignment = viewModel.isRightToLeft ? .right : .left
        self.textOfOriginalTweet.textAlignment = viewModel.isRightToLeft ? .right : .left
        self.avatarOfOriginalAuthor.kf.setImage(with: viewModel.imageURL)
        self.retweetingHeader.isHidden = !viewModel.isRetweet
        self.displayNameOfRetweetingUser.text = viewModel.retweetedBy
        self.mediaEntities = viewModel.mediaEntities
        self.tweetMediaGallery.reloadData()
        self.tweetMediaGallery.isHidden = viewModel.mediaEntities.isEmpty
        if viewModel.mediaEntities.count < 2 {
            self.enclosingViewOfPageControl.isHidden = true
        } else {
            self.enclosingViewOfPageControl.isHidden = false
            self.pageControlOfTweetGallery.numberOfPages = viewModel.mediaEntities.count
        }
        self.enclosingViewOfTweetGallery.isHidden = viewModel.mediaEntities.isEmpty
        self.retweetButton.setTitle(viewModel.numberOfRetweets.value, for: .normal)
        self.retweetButton.isSelected = viewModel.isRetweetedByUser.value ?? false
        self.likeButton.isSelected = viewModel.isLikedByUser.value ?? false
        self.likeButton.setTitle(viewModel.numberOfLikes.value, for: .normal)
        self.viewOfQuotedStatus.isHidden = !viewModel.isQuoted
        self.nameOfQuotedStatusAuthor.text = viewModel.nameOfQuotedStatusAuthor
        self.handleOfQuotedStatusAuthor.text = viewModel.handleOfQuotedStatusAuthor
        self.textOfQuotedStatus.text = viewModel.textOfQuotedStatus
        self.textOfQuotedStatus.textAlignment = viewModel.isQuotedStatusRTL ? .right : .left
        self.avatarOfQuotedStatusAuthor.kf.setImage(with: viewModel.avatarOfQuotedStatusAuthor)
        self.mediaEntityOfQuotedStatus.isHidden = !viewModel.quotedStatusHasMedia
        self.mediaEntityOfQuotedStatus.kf.setImage(with: viewModel.firstMediaEntityOfQuotedStatus)
    }
}
