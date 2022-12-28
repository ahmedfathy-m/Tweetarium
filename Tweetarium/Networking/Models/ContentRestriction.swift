//
//  ContentRestriction.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 28/12/2022.
//

import Foundation

enum ContentRestrictionScope: String, Codable {
    case status
    case user
}

enum ContentRestriction: Codable {
    case AllCountries
    case WithheldDMCA
    case WithheldInCountry(String)
    
    var restrictionCode: String {
        switch self {
        case .AllCountries: return "XX"
        case .WithheldDMCA: return "XY"
        case .WithheldInCountry(let code): return code
        }
    }
}
