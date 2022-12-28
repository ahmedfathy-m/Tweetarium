// Ahmed Fathy
// UserObject.swift
// According to Twitter API v1.1 documentation
// https://developer.twitter.com/en/docs/twitter-api/v1/data-dictionary/object-model/user

import Foundation

struct UserObject: Codable {
    let id: Int64
    let idStr: String
    let name: String
    let screenName: String
    let location: String?
    let derived: ProfileGeo? // Enterprise API Only
    let url: URL?
    let description: String?
    let protected: Bool
    let verified: Bool
    let followersCount: Int
    let followingCount: Int
    let listedCount: Int
    let likesCount: Int
    let tweetsCount: Int
    let createdAt: Date?
    let headerURL: URL?
    let profileImage: URL?
    let defaultProfile: Bool
    let defaultProfileImage: Bool
    let withheldInCountries: [String]
    let withheldScope: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, location, url, description, protected, verified
        case derived
        case idStr = "id_str"
        case screenName = "screen_name"
        case followersCount = "followers_count"
        case followingCount = "friends_count"
        case listedCount = "listed_count"
        case likesCount = "favourites_count"
        case tweetsCount = "statuses_count"
        case createdAt = "created_at"
        case headerURL = "profile_banner_url"
        case profileImage = "profile_image_url_https"
        case defaultProfile = "default_profile"
        case defaultProfileImage = "default_profile_image"
        case withheldInCountries = "withheld_in_countries"
        case withheldScope = "withheld_scope"
    }
    
    init(from decoder: Decoder) throws {
        id = try decoder.container(keyedBy: CodingKeys.self).decode(Int64.self, forKey: .id)
        idStr = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .idStr)
        name = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .name)
        screenName = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .screenName)
        location = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .location)
        derived = try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent(ProfileGeo.self, forKey: .derived)
        
        // Custom URL Initializer
        if let urlString = try decoder.container(keyedBy: CodingKeys.self).decode(String?.self, forKey: .url) {
            url = URL(string: urlString)
        } else { url = nil }
        
        if let headerURLString = try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent(String.self, forKey: .headerURL) {
            headerURL = URL(string: headerURLString)
        } else { headerURL = nil }
        
        if let profileImageString = try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent(String.self, forKey: .profileImage) {
            profileImage = URL(string: profileImageString)
        } else { profileImage = nil}
        
        description = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .description)
        protected = try decoder.container(keyedBy: CodingKeys.self).decode(Bool.self, forKey: .protected)
        verified = try decoder.container(keyedBy: CodingKeys.self).decode(Bool.self, forKey: .verified)
        followersCount = try decoder.container(keyedBy: CodingKeys.self).decode(Int.self, forKey: .followersCount)
        followingCount = try decoder.container(keyedBy: CodingKeys.self).decode(Int.self, forKey: .followingCount)
        listedCount = try decoder.container(keyedBy: CodingKeys.self).decode(Int.self, forKey: .listedCount)
        likesCount = try decoder.container(keyedBy: CodingKeys.self).decode(Int.self, forKey: .likesCount)
        tweetsCount = try decoder.container(keyedBy: CodingKeys.self).decode(Int.self, forKey: .tweetsCount)
        
        let dateString = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .createdAt)
        createdAt = Date.format(dateString)
        
        defaultProfile = try decoder.container(keyedBy: CodingKeys.self).decode(Bool.self, forKey: .defaultProfile)
        defaultProfileImage = try decoder.container(keyedBy: CodingKeys.self).decode(Bool.self, forKey: .defaultProfileImage)
        withheldInCountries = try decoder.container(keyedBy: CodingKeys.self).decode([String].self, forKey: .withheldInCountries)
        withheldScope = try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent(String.self, forKey: .withheldScope)
    }
}


// Enterprise API Only
struct Location: Codable {
    let country, countryCode, locality: String

    enum CodingKeys: String, CodingKey {
        case country
        case countryCode = "country_code"
        case locality
    }
}

struct ProfileGeo: Codable {
    let locations: [Location]
}
