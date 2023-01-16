//
//  TweetObjectView + TextViewDelegate.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 30/12/2022.
//

import UIKit

extension TweetObjectView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
    
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return false
    }
}
