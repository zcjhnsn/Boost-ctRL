// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let matchResults = try? newJSONDecoder().decode(MatchResults.self, from: jsonData)

import Foundation

// MARK: - MatchResults
struct MatchResponse: Codable {
    let matches: [Match]
    let page, perPage, pageSize: Int
}

// MARK: - Match
struct Match: Codable, Identifiable {
    let id, slug: String
    let event: Event
    let stage: Stage
    let date: String
    let format: Format
    let blue, orange: TeamResult
    let number: Int
    let games: [Game]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case slug, event, stage, date, format, blue, orange, number, games
    }
}

enum MatchResult {
    case loser
    case unknown
    case winner
}

// MARK: - TeamResults
struct TeamResult: Codable {
    let score: Int
    let teamInfo: TeamInfo
    let players: [PlayerResult]
    let winner: Bool
    
    enum CodingKeys: String, CodingKey {
        case teamInfo = "team"
        case score, players, winner
    }
    
    init(score: Int, teamInfo: TeamInfo, players: [PlayerResult], winner: Bool) {
        self.score = score
        self.teamInfo = teamInfo
        self.players = players
        self.winner = winner
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.score = try container.decodeIfPresent(Int.self, forKey: .score) ?? 0
        self.teamInfo = try container.decode(TeamInfo.self, forKey: .teamInfo)
        self.players = try container.decode([PlayerResult].self, forKey: .players)
        self.winner = try container.decodeIfPresent(Bool.self, forKey: .winner) ?? false
    }
}

// MARK: - PlayerElement
struct PlayerResult: Codable {
    let player: Player
    let stats: PlayerStats?
    let advanced: Advanced?
}

// MARK: - Advanced
struct Advanced: Codable {
    let goalParticipation, rating: Double
}

// MARK: - PlayerPlayer
struct Player: Codable, Identifiable {
    let id, slug, tag, country: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case slug, tag, country
    }
}

// MARK: - PlayerStats
struct PlayerStats: Codable {
    let core: Core
    let boost, movement, positioning: [String: Double]
    let demo: Demo
}

// MARK: - Core
struct Core: Codable {
    let shots, goals, saves, assists: Int
    let score: Int
    let shootingPercentage: Double
}

// MARK: - Demo
struct Demo: Codable {
    let inflicted, taken: Int
}

// MARK: - BlueTeam
struct TeamInfo: Codable {
    let team: Team
    let stats: TeamStats?
}

// MARK: - TeamStats
struct TeamStats: Codable {
    let core: Core
    let boost: [String: Double]
    let movement: Movement
    let positioning: Positioning
    let demo: Demo
}

// MARK: - Movement
struct Movement: Codable {
    let totalDistance: Int
    let timeSupersonicSpeed, timeBoostSpeed, timeSlowSpeed, timeGround: Double
    let timeLowAir, timeHighAir, timePowerslide: Double
    let countPowerslide: Int
}

// MARK: - Positioning
struct Positioning: Codable {
    let timeDefensiveThird, timeNeutralThird, timeOffensiveThird, timeDefensiveHalf: Double
    let timeOffensiveHalf, timeBehindBall, timeInfrontBall: Double
}

// MARK: - TeamTeam
struct Team: Codable, Identifiable {
    let id, slug, name: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case slug, name, image
    }
    
    init(id: String, slug: String, name: String, image: String) {
        self.id = id
        self.slug = slug
        self.name = name
        self.image = image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.slug = try container.decode(String.self, forKey: .slug)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
    }
}

// MARK: - Event
struct Event: Codable {
    let id, slug, name, region: String
    let mode: Int
    let tier: String
    let image: String
    let groups: [String]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case slug, name, region, mode, tier, image, groups
    }
}

// MARK: - Format
struct Format: Codable {
    let type: String
    let length: Int
}

// MARK: - Game
struct Game: Codable, Hashable {
    let id: String
    let blue, orange, duration: Int
    let overtime: Bool?
    let ballchasing: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case blue, orange, duration, overtime, ballchasing
    }
}

// MARK: - Stage
struct Stage: Codable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
    }
}
