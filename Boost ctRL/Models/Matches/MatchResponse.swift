// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let matchResults = try? newJSONDecoder().decode(MatchResults.self, from: jsonData)

import Foundation

// MARK: - MatchResults
struct MatchResponse: Codable {
    let matches: [Match]
    let page, perPage, pageSize: Int?
}


// MARK: - Match
struct Match: Codable, Identifiable, Hashable {
    static func == (lhs: Match, rhs: Match) -> Bool {
        return lhs.id == lhs.id
    }
    
    @DecodableDefault.ID var id: String
    let slug: String
    let event: Event
    let stage: Stage
    let date: String
    let format: Format
    @DecodableDefault.EmptyTeamResult var blue: TeamResult
    @DecodableDefault.EmptyTeamResult var orange: TeamResult
    let number: Int
    @DecodableDefault.EmptyList var games: [Game]

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
struct TeamResult: Codable, Hashable {
    @DecodableDefault.Zero var score: Int
    let teamInfo: TeamInfo
    @DecodableDefault.EmptyList var players: [PlayerResult]
    @DecodableDefault.False var winner: Bool
    
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
}

// MARK: - PlayerElement
struct PlayerResult: Codable, Hashable {
    let player: PlayerBasic
    let stats: PlayerStats?
    let advanced: Advanced?
}

// MARK: - Advanced
struct Advanced: Codable, Hashable {
    let goalParticipation, rating: Double
}

// MARK: - PlayerPlayer
struct PlayerBasic: Codable, Identifiable, Hashable {
    let id, slug, tag, country: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case slug, tag, country
    }
    
    init(id: String, slug: String, tag: String, country: String) {
        self.id = id
        self.slug = slug
        self.tag = tag
        self.country = country
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? "CTRLExamplePlayer"
        self.slug = try container.decodeIfPresent(String.self, forKey: .slug) ?? "ctrl-example-player"
        self.tag = try container.decodeIfPresent(String.self, forKey: .tag) ?? "TBD"
        self.country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
    }
}

// MARK: - PlayerStats
struct PlayerStats: Codable, Hashable {
    let core: Core
    let boost, movement, positioning: [String: Double]
    let demo: Demo
}

// MARK: - Core
struct Core: Codable, Hashable {
    let shots, goals, saves, assists: Int
    let score: Int
    let shootingPercentage: Double
}

// MARK: - Demo
struct Demo: Codable, Hashable {
    let inflicted, taken: Int
}

// MARK: - BlueTeam
struct TeamInfo: Codable, Hashable {
    @DecodableDefault.EmptyTeam var team: Team
    var stats: TeamStats?
    
    init(team: Team, stats: TeamStats?) {
        self.team = team
        self.stats = stats
    }
}

// MARK: - TeamStats
struct TeamStats: Codable, Hashable {
    static func == (lhs: TeamStats, rhs: TeamStats) -> Bool {
        return lhs.core == rhs.core &&
        lhs.boost == rhs.boost &&
        lhs.positioning == rhs.positioning &&
        lhs.movement == rhs.movement &&
        lhs.demo == rhs.demo
    }
    
    let core: Core
    let boost: [String: Double]
    let movement: Movement
    let positioning: Positioning
    let demo: Demo
}

// MARK: - Movement
struct Movement: Codable, Hashable, Equatable {
    let totalDistance: Int
    let timeSupersonicSpeed, timeBoostSpeed, timeSlowSpeed, timeGround: Double
    let timeLowAir, timeHighAir, timePowerslide: Double
    let countPowerslide: Int
}

// MARK: - Positioning
struct Positioning: Codable, Hashable, Equatable {
    let timeDefensiveThird, timeNeutralThird, timeOffensiveThird, timeDefensiveHalf: Double
    let timeOffensiveHalf, timeBehindBall, timeInfrontBall: Double
}

// MARK: - TeamTeam
struct Team: Codable, Identifiable, Hashable {
    
    var id: String
    @DecodableDefault.EmptyString var slug: String
    @DecodableDefault.EmptyString var name: String
    @DecodableDefault.EmptyString var image: String
    @DecodableDefault.EmptyString var region: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case slug, name, image, region
    }
    
    init(id: String, slug: String, name: String, image: String, region: String) {
        self.id = id
        self.slug = slug
        self.name = name
        self.image = image
        self.region = region
    }
    
    func getRegionName() -> String {
        switch self.region.lowercased() {
        case AppConstants.Region.na:
            return "North America"
        case AppConstants.Region.eu:
            return "Europe"
        case AppConstants.Region.oce:
            return "Oceania"
        case AppConstants.Region.sam:
            return "South America"
        case AppConstants.Region.me:
            return "Middle East"
        case AppConstants.Region.asia:
            return "Asia"
        case AppConstants.Region.af:
            return "Africa"
        case AppConstants.Region.int:
            return "International"
        default:
            return "Unknown"
        }
    }
    
    func isSameTeam(as teamID: String) -> Bool {
        return id == teamID || slug == teamID
    }
}

// MARK: - Format
struct Format: Codable, Hashable {
    let type: String
    let length: Int
}

// MARK: - Game
struct Game: Codable, Hashable {
    @DecodableDefault.ID var id: String
    let blue, orange: Int
    @DecodableDefault.Zero var duration: Int
    @DecodableDefault.False var overtime: Bool
    let ballchasing: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case blue, orange, duration, overtime, ballchasing
    }
}
