//
//  CreateTweetPopup+UITextViewDelegate.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 15/01/2023.
//

import UIKit

extension CreateTweetPopup: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "What's Happening?!!"~ {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What's Happening?!!"~
            textView.textColor = .placeholderText
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.observeTextChange(textView.text, isPlaceHolder: textView.textColor == .placeholderText)
    }
}
