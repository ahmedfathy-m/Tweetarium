// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let timeline = try? newJSONDecoder().decode(Timeline.self, from: jsonData)

import Foundation

// MARK: - Tweet
struct Tweet: Codable {
    let createdAt: String
    let id: Double
    let idStr, fullText: String
    let truncated: Bool
    let displayTextRange: [Int]
    let entities: TweetEntities
    let extendedEntities: ExtendedEntities?
    let source: String
    let inReplyToStatusID: Double?
    let inReplyToStatusIDStr: String?
    let inReplyToUserID: Double?
    let inReplyToUserIDStr, inReplyToScreenName: String?
    let user: User
    let geo, coordinates, place, contributors: JSONNull?
    let isQuoteStatus: Bool
    let retweetCount, favoriteCount: Int
    let favorited, retweeted: Bool
    let possiblySensitive, possiblySensitiveAppealable: Bool?
    let lang: Lang
    let quotedStatusID: Double?
    let quotedStatusIDStr: String?
    let quotedStatusPermalink: QuotedStatusPermalink?
    let quotedStatus: QuotedStatus?

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id
        case idStr = "id_str"
        case fullText = "full_text"
        case truncated
        case displayTextRange = "display_text_range"
        case entities
        case extendedEntities = "extended_entities"
        case source
        case inReplyToStatusID = "in_reply_to_status_id"
        case inReplyToStatusIDStr = "in_reply_to_status_id_str"
        case inReplyToUserID = "in_reply_to_user_id"
        case inReplyToUserIDStr = "in_reply_to_user_id_str"
        case inReplyToScreenName = "in_reply_to_screen_name"
        case user, geo, coordinates, place, contributors
        case isQuoteStatus = "is_quote_status"
        case retweetCount = "retweet_count"
        case favoriteCount = "favorite_count"
        case favorited, retweeted
        case possiblySensitive = "possibly_sensitive"
        case possiblySensitiveAppealable = "possibly_sensitive_appealable"
        case lang
        case quotedStatusID = "quoted_status_id"
        case quotedStatusIDStr = "quoted_status_id_str"
        case quotedStatusPermalink = "quoted_status_permalink"
        case quotedStatus = "quoted_status"
    }
}

// MARK: - TweetEntities
struct TweetEntities: Codable {
    let hashtags: [Hashtag]
    let symbols: [JSONAny]
    let userMentions: [UserMention]
    let urls: [URLElement]
    let media: [PurpleMedia]?

    enum CodingKeys: String, CodingKey {
        case hashtags, symbols
        case userMentions = "user_mentions"
        case urls, media
    }
}

// MARK: - Hashtag
struct Hashtag: Codable {
    let text: String
    let indices: [Int]
}

// MARK: - PurpleMedia
struct PurpleMedia: Codable {
    let id: Double
    let idStr: String
    let indices: [Int]
    let mediaURL: String
    let mediaURLHTTPS: String
    let url: String
    let displayURL: String
    let expandedURL: String
    let type: TypeEnum
    let sizes: Sizes
    let videoInfo: VideoInfo?
    let additionalMediaInfo: PurpleAdditionalMediaInfo?

    enum CodingKeys: String, CodingKey {
        case id
        case idStr = "id_str"
        case indices
        case mediaURL = "media_url"
        case mediaURLHTTPS = "media_url_https"
        case url
        case displayURL = "display_url"
        case expandedURL = "expanded_url"
        case type, sizes
        case videoInfo = "video_info"
        case additionalMediaInfo = "additional_media_info"
    }
}

// MARK: - PurpleAdditionalMediaInfo
struct PurpleAdditionalMediaInfo: Codable {
    let monetizable: Bool
}

// MARK: - Sizes
struct Sizes: Codable {
    let medium, thumb, small, large: Large
}

// MARK: - Large
struct Large: Codable {
    let w, h: Int
    let resize: Resize
}

enum Resize: String, Codable {
    case crop = "crop"
    case fit = "fit"
}

enum TypeEnum: String, Codable {
    case photo = "photo"
    case video = "video"
}

// MARK: - VideoInfo
struct VideoInfo: Codable {
    let aspectRatio: [Int]
    let durationMillis: Int
    let variants: [Variant]

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case durationMillis = "duration_millis"
        case variants
    }
}

// MARK: - Variant
struct Variant: Codable {
    let bitrate: Int?
    let contentType: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case bitrate
        case contentType = "content_type"
        case url
    }
}

// MARK: - URLElement
struct URLElement: Codable {
    let url: String
    let expandedURL: String
    let displayURL: String
    let indices: [Int]

    enum CodingKeys: String, CodingKey {
        case url
        case expandedURL = "expanded_url"
        case displayURL = "display_url"
        case indices
    }
}

// MARK: - UserMention
struct UserMention: Codable {
    let screenName, name: String
    let id: Double
    let idStr: String
    let indices: [Int]

    enum CodingKeys: String, CodingKey {
        case screenName = "screen_name"
        case name, id
        case idStr = "id_str"
        case indices
    }
}

// MARK: - ExtendedEntities
struct ExtendedEntities: Codable {
    let media: [PurpleMedia]
}

enum Lang: String, Codable {
    case ar = "ar"
    case art = "art"
    case en = "en"
}

// MARK: - QuotedStatus
struct QuotedStatus: Codable {
    let createdAt: String
    let id: Double
    let idStr, fullText: String
    let truncated: Bool
    let displayTextRange: [Int]
    let entities: QuotedStatusEntities
    let extendedEntities: QuotedStatusExtendedEntities?
    let source: String
    let inReplyToStatusID, inReplyToStatusIDStr, inReplyToUserID, inReplyToUserIDStr: JSONNull?
    let inReplyToScreenName: JSONNull?
    let user: User
    let geo, coordinates, place, contributors: JSONNull?
    let isQuoteStatus: Bool
    let retweetCount, favoriteCount: Int
    let favorited, retweeted: Bool
    let possiblySensitive, possiblySensitiveAppealable: Bool?
    let lang: Lang

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id
        case idStr = "id_str"
        case fullText = "full_text"
        case truncated
        case displayTextRange = "display_text_range"
        case entities
        case extendedEntities = "extended_entities"
        case source
        case inReplyToStatusID = "in_reply_to_status_id"
        case inReplyToStatusIDStr = "in_reply_to_status_id_str"
        case inReplyToUserID = "in_reply_to_user_id"
        case inReplyToUserIDStr = "in_reply_to_user_id_str"
        case inReplyToScreenName = "in_reply_to_screen_name"
        case user, geo, coordinates, place, contributors
        case isQuoteStatus = "is_quote_status"
        case retweetCount = "retweet_count"
        case favoriteCount = "favorite_count"
        case favorited, retweeted
        case possiblySensitive = "possibly_sensitive"
        case possiblySensitiveAppealable = "possibly_sensitive_appealable"
        case lang
    }
}

// MARK: - QuotedStatusEntities
struct QuotedStatusEntities: Codable {
    let hashtags, symbols, userMentions, urls: [JSONAny]
    let media: [FluffyMedia]?

    enum CodingKeys: String, CodingKey {
        case hashtags, symbols
        case userMentions = "user_mentions"
        case urls, media
    }
}

// MARK: - FluffyMedia
struct FluffyMedia: Codable {
    let id: Double
    let idStr: String
    let indices: [Int]
    let mediaURL: String
    let mediaURLHTTPS: String
    let url: String
    let displayURL: String
    let expandedURL: String
    let type: TypeEnum
    let sizes: Sizes
    let sourceStatusID: Double?
    let sourceStatusIDStr: String?
    let sourceUserID: Int?
    let sourceUserIDStr: String?
    let videoInfo: VideoInfo?
    let additionalMediaInfo: FluffyAdditionalMediaInfo?

    enum CodingKeys: String, CodingKey {
        case id
        case idStr = "id_str"
        case indices
        case mediaURL = "media_url"
        case mediaURLHTTPS = "media_url_https"
        case url
        case displayURL = "display_url"
        case expandedURL = "expanded_url"
        case type, sizes
        case sourceStatusID = "source_status_id"
        case sourceStatusIDStr = "source_status_id_str"
        case sourceUserID = "source_user_id"
        case sourceUserIDStr = "source_user_id_str"
        case videoInfo = "video_info"
        case additionalMediaInfo = "additional_media_info"
    }
}

// MARK: - FluffyAdditionalMediaInfo
struct FluffyAdditionalMediaInfo: Codable {
    let monetizable: Bool
    let sourceUser: SourceUser

    enum CodingKeys: String, CodingKey {
        case monetizable
        case sourceUser = "source_user"
    }
}

// MARK: - SourceUser
struct SourceUser: Codable {
    let id: Int
    let idStr, name, screenName, location: String
    let sourceUserDescription: String
    let url: JSONNull?
    let entities: SourceUserEntities
    let protected: Bool
    let followersCount, friendsCount, listedCount: Int
    let createdAt: String
    let favouritesCount: Int
    let utcOffset, timeZone: JSONNull?
    let geoEnabled, verified: Bool
    let statusesCount: Int
    let lang: JSONNull?
    let contributorsEnabled, isTranslator, isTranslationEnabled: Bool
    let profileBackgroundColor: ProfileColor
    let profileBackgroundImageURL: String
    let profileBackgroundImageURLHTTPS: String
    let profileBackgroundTile: Bool
    let profileImageURL: String
    let profileImageURLHTTPS: String
    let profileBannerURL: String
    let profileLinkColor: String
    let profileSidebarBorderColor: ProfileColor
    let profileSidebarFillColor, profileTextColor: String
    let profileUseBackgroundImage, hasExtendedProfile, defaultProfile, defaultProfileImage: Bool
    let following, followRequestSent, notifications: Bool
    let translatorType: TranslatorType
    let withheldInCountries: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id
        case idStr = "id_str"
        case name
        case screenName = "screen_name"
        case location
        case sourceUserDescription = "description"
        case url, entities, protected
        case followersCount = "followers_count"
        case friendsCount = "friends_count"
        case listedCount = "listed_count"
        case createdAt = "created_at"
        case favouritesCount = "favourites_count"
        case utcOffset = "utc_offset"
        case timeZone = "time_zone"
        case geoEnabled = "geo_enabled"
        case verified
        case statusesCount = "statuses_count"
        case lang
        case contributorsEnabled = "contributors_enabled"
        case isTranslator = "is_translator"
        case isTranslationEnabled = "is_translation_enabled"
        case profileBackgroundColor = "profile_background_color"
        case profileBackgroundImageURL = "profile_background_image_url"
        case profileBackgroundImageURLHTTPS = "profile_background_image_url_https"
        case profileBackgroundTile = "profile_background_tile"
        case profileImageURL = "profile_image_url"
        case profileImageURLHTTPS = "profile_image_url_https"
        case profileBannerURL = "profile_banner_url"
        case profileLinkColor = "profile_link_color"
        case profileSidebarBorderColor = "profile_sidebar_border_color"
        case profileSidebarFillColor = "profile_sidebar_fill_color"
        case profileTextColor = "profile_text_color"
        case profileUseBackgroundImage = "profile_use_background_image"
        case hasExtendedProfile = "has_extended_profile"
        case defaultProfile = "default_profile"
        case defaultProfileImage = "default_profile_image"
        case following
        case followRequestSent = "follow_request_sent"
        case notifications
        case translatorType = "translator_type"
        case withheldInCountries = "withheld_in_countries"
    }
}

// MARK: - SourceUserEntities
struct SourceUserEntities: Codable {
    let entitiesDescription: Description

    enum CodingKeys: String, CodingKey {
        case entitiesDescription = "description"
    }
}

// MARK: - Description
struct Description: Codable {
    let urls: [URLElement]
}

enum ProfileColor: String, Codable {
    case a8C7F7 = "A8C7F7"
    case c0Deed = "C0DEED"
    case ffffff = "FFFFFF"
    case the000000 = "000000"
}

enum TranslatorType: String, Codable {
    case none = "none"
    case regular = "regular"
}

// MARK: - QuotedStatusExtendedEntities
struct QuotedStatusExtendedEntities: Codable {
    let media: [FluffyMedia]
}

// MARK: - User
struct User: Codable {
    let id: Double
    let idStr, name, screenName, location: String
    let userDescription: String
    let url: String?
    let entities: UserEntities
    let protected: Bool
    let followersCount, friendsCount, listedCount: Int
    let createdAt: String
    let favouritesCount: Int
    let utcOffset, timeZone: JSONNull?
    let geoEnabled, verified: Bool
    let statusesCount: Int
    let lang: JSONNull?
    let contributorsEnabled, isTranslator, isTranslationEnabled: Bool
    let profileBackgroundColor: String
    let profileBackgroundImageURL: String?
    let profileBackgroundImageURLHTTPS: String?
    let profileBackgroundTile: Bool
    let profileImageURL: String
    let profileImageURLHTTPS: String
    let profileBannerURL: String?
    let profileLinkColor: String
    let profileSidebarBorderColor: ProfileColor
    let profileSidebarFillColor, profileTextColor: String
    let profileUseBackgroundImage, hasExtendedProfile, defaultProfile, defaultProfileImage: Bool
    let following, followRequestSent, notifications: Bool
    let translatorType: TranslatorType
    let withheldInCountries: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id
        case idStr = "id_str"
        case name
        case screenName = "screen_name"
        case location
        case userDescription = "description"
        case url, entities, protected
        case followersCount = "followers_count"
        case friendsCount = "friends_count"
        case listedCount = "listed_count"
        case createdAt = "created_at"
        case favouritesCount = "favourites_count"
        case utcOffset = "utc_offset"
        case timeZone = "time_zone"
        case geoEnabled = "geo_enabled"
        case verified
        case statusesCount = "statuses_count"
        case lang
        case contributorsEnabled = "contributors_enabled"
        case isTranslator = "is_translator"
        case isTranslationEnabled = "is_translation_enabled"
        case profileBackgroundColor = "profile_background_color"
        case profileBackgroundImageURL = "profile_background_image_url"
        case profileBackgroundImageURLHTTPS = "profile_background_image_url_https"
        case profileBackgroundTile = "profile_background_tile"
        case profileImageURL = "profile_image_url"
        case profileImageURLHTTPS = "profile_image_url_https"
        case profileBannerURL = "profile_banner_url"
        case profileLinkColor = "profile_link_color"
        case profileSidebarBorderColor = "profile_sidebar_border_color"
        case profileSidebarFillColor = "profile_sidebar_fill_color"
        case profileTextColor = "profile_text_color"
        case profileUseBackgroundImage = "profile_use_background_image"
        case hasExtendedProfile = "has_extended_profile"
        case defaultProfile = "default_profile"
        case defaultProfileImage = "default_profile_image"
        case following
        case followRequestSent = "follow_request_sent"
        case notifications
        case translatorType = "translator_type"
        case withheldInCountries = "withheld_in_countries"
    }
}

// MARK: - UserEntities
struct UserEntities: Codable {
    let url: Description?
    let entitiesDescription: Description

    enum CodingKeys: String, CodingKey {
        case url
        case entitiesDescription = "description"
    }
}

// MARK: - QuotedStatusPermalink
struct QuotedStatusPermalink: Codable {
    let url, expanded: String
    let display: String
}

typealias Timeline = [Tweet]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
