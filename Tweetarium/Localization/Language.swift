//
//  Language.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 20/01/2023.
//

import Foundation

enum Language: String, Identifiable, CaseIterable {
    case arabic = "العربية"
    case english = "English"
    var id: String { self.rawValue }
    var key: String {
        switch self {
        case .arabic:
            return "ar"
        case .english:
            return "en"
        }
    }
}
