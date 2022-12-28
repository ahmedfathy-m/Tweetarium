//
//  Poll.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 28/12/2022.
//

import Foundation

struct PollObject: Codable {
    let options: [Option]
    let endDatetime: String
    let durationMinutes: Int

    enum CodingKeys: String, CodingKey {
        case options
        case endDatetime = "end_datetime"
        case durationMinutes = "duration_minutes"
    }
}

struct Option: Codable {
    let position: Int
    let text: String
}
