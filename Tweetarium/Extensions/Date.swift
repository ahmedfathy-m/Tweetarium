//
//  Date.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 28/12/2022.
//

import Foundation

extension Date {
    static func format(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        let date = dateFormatter.date(from: dateString)
        return date
    }
    
    func calculateDuration() -> String {
        let durationSinceDate = Date.now.timeIntervalSince(self)
        
        var displayTime = ""
        
        if durationSinceDate < 60 {
            displayTime = String(format: "%.0fs", durationSinceDate)
        } else if durationSinceDate > 60 && durationSinceDate < 3600 {
            displayTime = String(format: "%.0fm", durationSinceDate / 60.0)
        } else if durationSinceDate > 3600 && durationSinceDate < 86400 {
            displayTime = String(format: "%.0fh", durationSinceDate / 3600)
        } else {
            displayTime = String(format: "%.0fd", durationSinceDate / 86400)
        }
        
        return displayTime
    }
}
