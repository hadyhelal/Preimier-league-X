//
//  MatchesModel.swift
//  Premier League X
//
//  Created by Hady on 15/10/2023.
//

import Foundation


// MARK: - Welcome
struct MatchesModel: Codable {
    let filters: Filters?
    let resultSet: ResultSet?
    let competition: Competition?
    let matches: [Match]?
}

// MARK: - Competition
struct Competition: Codable {
    let id: Int?
    let name: String?
    let code: String?
    let type: String?
    let emblem: String?
}

// MARK: - Filters
struct Filters: Codable {
    let season: String?
}

// MARK: - Match
struct Match: Codable, Equatable {
    static func == (lhs: Match, rhs: Match) -> Bool {
        lhs.id == rhs.id
    }
    
    let area: Area?
    let competition: Competition?
    let season: Season?
    let id: Int?
    let utcDate: String?
    let status: Status?
    let matchday: Int?
    let stage: String?
    let group: JSONNull?
    let lastUpdated: String?
    let homeTeam, awayTeam: Team?
    let score: Score?
    let odds: Odds?
    let referees: [Referee]?
    
    var isFavorite: Bool = false
    var matchDate: Date {
        DateFormatterManager.getLeagueDate(utcDate ?? "")
    }
    
    enum CodingKeys: String, CodingKey {
        case area, competition, season, id, utcDate, status, matchday, stage, group
        case lastUpdated, homeTeam, awayTeam
        case score, odds, referees
    }
}

// MARK: - Area
struct Area: Codable {
    let id: Int?
    let name: String?
    let code: String?
    let flag: String?
}

enum AreaCode: String, Codable {
    case eng = "ENG"
}

// MARK: - Team
struct Team: Codable {
    let id: Int?
    let name: String?
    let shortName: String?
    let tla: String?
    let crest: String?
}

// MARK: - Odds
struct Odds: Codable {
    let msg: String?
}


// MARK: - Referee
struct Referee: Codable {
    let id: Int?
    let name: String?
    let type: String?
    let nationality: String?
}


// MARK: - Score
struct Score: Codable {
    let winner: String?
    let duration: String?
    let fullTime, halfTime: Time?
}


// MARK: - Time
struct Time: Codable {
    let home, away: Int?
}

// MARK: - Season
struct Season: Codable {
    let id: Int?
    let startDate, endDate: String?
    let currentMatchday: Int?
    let winner: JSONNull?
}

enum Status: String, Codable {
    case finished = "FINISHED"
    case scheduled = "SCHEDULED"
    case timed = "TIMED"
}

// MARK: - ResultSet
struct ResultSet: Codable {
    let count: Int?
    let first, last: String?
    let played: Int?
}


// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    func hash(into hasher: inout Hasher) { }
    
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
