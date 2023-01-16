//
//  ScreenType.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 27/12/2022.
//

import Foundation

enum TimelineType: Int {
    case mentions
    case home
    case profile
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .mentions: return "Mentions"
        case .profile: return "Me"
        }
    }
    
    var itemImage: String {
        switch self {
        case .home: return "house"
        case .mentions: return "message"
        case .profile: return "person"
        }
    }
}
