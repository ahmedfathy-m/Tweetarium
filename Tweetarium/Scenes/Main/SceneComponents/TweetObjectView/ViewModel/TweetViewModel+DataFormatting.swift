//
//  TweetViewModel+DataFormatting.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 15/01/2023.
//

import Foundation
import UIKit


// MARK: - Static Values returned from model
extension TweetViewModel {
    var tweetID: Int {
        Int(model.id)
    }
    
    var displayName: String {
        displayTweet.user.name
    }
    
    var displayHandle: String {
        "@\(displayTweet.user.screenName)"
    }
    
    var displayTweet: TweetObject {
        let value = isRetweet ? model.retweetedTweet! : model
        return value
    }
    
    var tweetURL: String {
        let url = "https://twitter.com/\(displayTweet.user.screenName)/status/\(displayTweet.idStr)"
        return url
    }
    
    fileprivate var entities: Entity {
        return displayTweet.entities
    }
    
    fileprivate var tweetText: String {
        if let displayText = displayTweet.text { return displayText }
        else if let displayText = displayTweet.fullText { return displayText }
        else { return String() }
    }
    
    var displayText: NSAttributedString {
        var value = tweetText

        entities.urls?.forEach { urlObject in
            if urlObject.displayURL.starts(with: "twitter.com") {
                value = value.replacingOccurrences(of: urlObject.url, with: "")
            } else {
                value = value.replacingOccurrences(of: urlObject.url, with: urlObject.displayURL)
            }
        }
        
        entities.media?.forEach { mediaObject in
            value = value.replacingOccurrences(of: mediaObject.url, with: "")
        }
        
        value = value.replacingOccurrences(of: "&amp;", with: "&")
        
        let mutableAttributedString = NSMutableAttributedString(string: value)
        let updatedRange = NSMakeRange(0, value.count)
//        let hashtagPattern = "#[A-Za-z0-9]*|@[A-Za-z0-9]*"
        let hashtagPattern = "(#+[a-zA-Z0-9A-Za-zÀ-ÖØ-öø-ʸ(_)]{1,})|(@+[a-zA-Z0-9(_)]{1,})"
        let hashtagRegex = try? NSRegularExpression(pattern: hashtagPattern, options: [])
        let matches = hashtagRegex?.matches(in: value, options: [], range: updatedRange)
        
        matches?.reversed().forEach { match in
            mutableAttributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: match.range)
        }
        
        return NSAttributedString(attributedString: mutableAttributedString)
    }
    
    var isRightToLeft: Bool {
        displayTweet.lang == .Arabic
    }
    
    var imageURL: URL? {
        displayTweet.user.profileImage
    }
    
    var isRetweet: Bool {
        return model.retweetedTweet != nil
    }
    
    var retweetedBy: String? {
        guard isRetweet else { return nil }
        return "Retweeted By \(model.user.name)"
    }
    
    var mediaEntities: [URL?] {
        let media = isRetweet ? model.retweetedTweet!.entities.media : model.extendedEntities?.media
        let urls = media?.map({ URL(string: $0.mediaURLHTTPS) })
        return urls ?? [URL]()
    }
    
    var postedSince: String {
        let date = displayTweet.createdAt
        return date?.calculateDuration() ?? ""
    }
    
    // MARK: - Quoted Status
    
    var isQuoted: Bool {
        displayTweet.isQuotingAnotherTweet
    }
    
    var textOfQuotedStatus: String? {
        if let text = displayTweet.quotedTweet?.text {
            return text
        } else {
            return displayTweet.quotedTweet?.fullText
        }
    }
    
    var nameOfQuotedStatusAuthor: String? {
        displayTweet.quotedTweet?.user.name
    }
    
    var handleOfQuotedStatusAuthor: String? {
        guard let value = displayTweet.quotedTweet?.user.screenName else { return nil }
        return "@\(value)"
    }
    
    var avatarOfQuotedStatusAuthor: URL? {
        displayTweet.quotedTweet?.user.profileImage
    }
    
    var isQuotedStatusRTL: Bool {
        displayTweet.quotedTweet?.lang == .Arabic
    }
    
    var quotedStatusHasMedia: Bool {
        guard firstMediaEntityOfQuotedStatus != nil else { return false }
        return true
    }
    
    var firstMediaEntityOfQuotedStatus: URL? {
        guard let value = displayTweet.quotedTweet?.entities.media?[0].mediaURLHTTPS else { return nil }
        return URL(string: value)
    }
}
