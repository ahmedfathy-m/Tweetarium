//
//  TweetViewModel.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 14/12/2022.
//

import Foundation

struct TweetViewModel {
    let model: Tweet
}

extension TweetViewModel {
    var displayName: String {
        return model.user.name
    }
    
    var displayHandle: String {
        return model.user.screenName
    }
    
    var tweetText: String {
        return model.fullText
    }
    
    var numberOfLikes: Int {
        return model.favoriteCount
    }
    
    var numberOfRetweets: Int {
        return model.retweetCount
    }
    
    var isRightToLeft: Bool {
        return model.lang == .ar
    }
    
    var imageURL: String {
        return model.user.profileImageURLHTTPS
    }
    
    var postedSince: String {
        let dateComponents = model.createdAt.components(separatedBy: " ")
        let weekday = dateComponents[0]
        let month = dateComponents[1]
        let day = dateComponents[2]
        let time = dateComponents[3]
        let year = dateComponents[5]
        print(#function)
        print(dateComponents)
        
        let monthNumber = monthFormatter(monthName: month)
        print(monthNumber)
        
        let isoDate = "\(year)-\(monthNumber)-\(day) \(time)"
        print(isoDate)
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = .gmt
        let date = formatter.date(from: isoDate)
        print(date)
        let secondsPast = abs(date!.timeIntervalSinceNow)
        var displayTime = ""
        
        if secondsPast < 60 {
            displayTime = String(format: "%.0fs", secondsPast)
        } else if secondsPast > 60 && secondsPast < 3600 {
            displayTime = String(format: "%.0fm", secondsPast / 60.0)
        } else if secondsPast > 3600 && secondsPast < 86400 {
            displayTime = String(format: "%.0fh", secondsPast / 3600)
        } else {
            displayTime = String(format: "%.0fd", secondsPast / 86400)
        }
        
        return displayTime
    }
    
    fileprivate func monthFormatter(monthName: String) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "LLL"  // if you need 3 letter month just use "LLL"
        if let date = df.date(from: monthName) {
            let month = Calendar.current.component(.month, from: date)
            return month > 9 ? "\(month)" : "0\(month)"
        }
        return "00"
    }
}
