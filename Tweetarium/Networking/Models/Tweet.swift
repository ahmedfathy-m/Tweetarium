// Ahmed Fathy
// Tweet.swift
// According to Twitter API v1.1 documentation
// https://developer.twitter.com/en/docs/twitter-api/v1/data-dictionary/object-model/tweet

import Foundation

typealias Timeline = [TweetObject]

final class TweetObject: Codable {
    let createdAt: Date?
    let text: String?
    let fullText: String?
    
    let id: Int64
    let idStr: String
    let source: String
    let truncated: Bool
    
    let inReplyToTweetID: Int64?
    let inReplyToTweetIDStr: String?
    let inReplyToUserID: Int64?
    let inReplyToUserIDStr: String?
    let inReplyToScreenName: String?
    
    let user: UserObject
    let coordinates: Coordinates?
    let place: PlaceObject?
    
    let isQuotingAnotherTweet: Bool
    let quotedStatusID: Int64? // If Present
    let quotedStatusIDStr: String? // If Present
    let quotedTweet: TweetObject? // If Present
    let retweetedTweet: TweetObject? // If Present
    
    let numberOfQuotes: Int? // Enterprise Only
    let numberOfReplies: Int? // Enterprise Only
    let numberOfRetweets: Int
    let numberOfLikes: Int?
    
    let entities: Entity
    let extendedEntities: Entity?
    
    let isLikedByAuthenticatedUser: Bool?
    let isRetweetedByAuthenticatedUser: Bool
    
    let doesContainSensitiveContent: Bool?
    let filterLevel: FilterLevel?
    let lang: TwitterLang?
    let matchingRules: [MatchingRule]? // Only in Twitter Search
    
    // MARK: - Additional Attributes
    let currentUserRetweet: UserRetweet? // Present If include_my_retweet == true
    let withheldCopyright: Bool? // If Present, It indicates content was withheld due to a DMCA complaint
    let withheldInCountries: [ContentRestriction]?
    let withheldScope: ContentRestrictionScope?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id, source, truncated, user, coordinates, place, entities, lang
        case idStr = "id_str"
        case text = "text"
        case fullText = "full_text"
        case inReplyToTweetID = "in_reply_to_status_id"
        case inReplyToTweetIDStr = "in_reply_to_status_id_str"
        case inReplyToUserID = "in_reply_to_user_id"
        case inReplyToUserIDStr = "in_reply_to_user_id_str"
        case inReplyToScreenName = "in_reply_to_screen_name"
        case isQuotingAnotherTweet = "is_quote_status"
        case quotedStatusID = "quoted_status_id"
        case quotedStatusIDStr = "quoted_status_id_str"
        case quotedTweet = "quoted_status"
        case retweetedTweet = "retweeted_status"
        case numberOfQuotes = "quote_count"
        case numberOfReplies = "reply_count"
        case numberOfRetweets = "retweet_count"
        case numberOfLikes = "favorite_count"
        case extendedEntities = "extended_entities"
        case isLikedByAuthenticatedUser = "favorited"
        case isRetweetedByAuthenticatedUser = "retweeted"
        case doesContainSensitiveContent = "possibly_sensitive"
        case filterLevel = "filter_level"
        case matchingRules = "matching_rules"
        case currentUserRetweet = "current_user_retweet"
        case withheldCopyright = "withheld_copyright"
        case withheldInCountries = "withheld_in_countries"
        case withheldScope = "withheld_scope"
    }
    
    init(from decoder: Decoder) throws {
        // MARK: - Date Decoding
        let dateOfCreateion = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .createdAt)
        print(#file)
        print(dateOfCreateion)
        createdAt = Date.format(dateOfCreateion)
        print(createdAt)
        
        // MARK: - Tweet Content Decoding
        text = try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent(String.self, forKey: .text)
        fullText = try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent(String.self, forKey: .fullText)
        
        // MARK: - Rest of Parameters
        id = try decoder.container(keyedBy: CodingKeys.self).decode(Int64.self, forKey: .id)
        idStr = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .idStr)
        source = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .source)
        truncated = try decoder.container(keyedBy: CodingKeys.self).decode(Bool.self, forKey: .truncated)
        
        inReplyToTweetID = try decoder.container(keyedBy: CodingKeys.self).decode(Int64?.self, forKey: .inReplyToTweetID)
        inReplyToTweetIDStr = try decoder.container(keyedBy: CodingKeys.self).decode(String?.self, forKey: .inReplyToTweetIDStr)
        inReplyToUserID = try decoder.container(keyedBy: CodingKeys.self).decode(Int64?.self, forKey: .inReplyToUserID)
        inReplyToUserIDStr = try decoder.container(keyedBy: CodingKeys.self).decode(String?.self, forKey: .inReplyToUserIDStr)
        inReplyToScreenName = try decoder.container(keyedBy: CodingKeys.self).decode(String?.self, forKey: .inReplyToScreenName)
        
        user = try decoder.container(keyedBy: CodingKeys.self).decode(UserObject.self, forKey: .user)
        coordinates = try decoder.container(keyedBy: CodingKeys.self).decode(Coordinates?.self, forKey: .coordinates)
        place = try decoder.container(keyedBy: CodingKeys.self).decode(PlaceObject?.self, forKey: .place)
        
        isQuotingAnotherTweet = try decoder.container(keyedBy: CodingKeys.self).decode(Bool.self, forKey: .isQuotingAnotherTweet)
        quotedStatusID = try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent(Int64.self, forKey: .quotedStatusID)
        quotedStatusIDStr = try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent(String.self, forKey: .quotedStatusIDStr)
        quotedTweet = try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent(TweetObject.self, forKey: .quotedTweet)
        retweetedTweet = try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent(TweetObject.self, forKey: .retweetedTweet)
        
        numberOfQuotes = try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent(Int.self, forKey: .numberOfQuotes)
        numberOfReplies = try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent(Int.self, forKey: .numberOfReplies)
        numberOfLikes = try decoder.container(keyedBy: CodingKeys.self).decode(Int?.self, forKey: .numberOfLikes)
        numberOfRetweets = try decoder.container(keyedBy: CodingKeys.self).decode(Int.self, forKey: .numberOfRetweets)
        
        entities = try decoder.container(keyedBy: CodingKeys.self).decode(Entity.self, forKey: .entities)
        extendedEntities = try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent(Entity.self, forKey: .extendedEntities)
        
        isLikedByAuthenticatedUser = try decoder.container(keyedBy: CodingKeys.self).decode(Bool?.self, forKey: .isLikedByAuthenticatedUser)
        isRetweetedByAuthenticatedUser = try decoder.container(keyedBy: CodingKeys.self).decode(Bool.self, forKey: .isRetweetedByAuthenticatedUser)
        
        doesContainSensitiveContent = try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent(Bool.self, forKey: .doesContainSensitiveContent)
        filterLevel = try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent(FilterLevel.self, forKey: .filterLevel)
        
        if let retrievedLang = try? decoder.container(keyedBy: CodingKeys.self).decode(TwitterLang.self, forKey: .lang) {
            lang = retrievedLang
        } else { lang = .undefined }
        
        matchingRules = try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent([MatchingRule].self, forKey: .matchingRules)
        
        currentUserRetweet = try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent(UserRetweet.self, forKey: .currentUserRetweet)
        withheldCopyright = try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent(Bool.self, forKey: .withheldCopyright)
        withheldInCountries = try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent([ContentRestriction].self, forKey: .withheldInCountries)
        withheldScope = try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent(ContentRestrictionScope.self, forKey: .withheldScope)
    }
}
