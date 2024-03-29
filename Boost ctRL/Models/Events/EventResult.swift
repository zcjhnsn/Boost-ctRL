//
//  EventResult.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 8/2/21.
//

import Foundation

// MARK: - EventResult
struct EventResult: Codable {
    let id, slug, name: String
    let startDate, endDate: Date
    let region: String
    let mode: Int
    @DecodableDefault.NoPrize var prize: Prize
    let tier: String
    let image: String?
    let groups: [String]?
    let stages: [EventStage]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case slug, name, startDate, endDate, region, mode, prize, tier, image, groups, stages
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
    
    func hasLAN() -> Bool {
        return stages.contains(where: { $0.lan == true })
    }
}

// MARK: - Prize
struct Prize: Codable, Hashable {
    let amount: Double
    let currency: String
    
    init(amount: Double, currency: String) {
        self.amount = amount
        self.currency = currency
    }
}

// MARK: - Stage
struct EventStage: Codable {
    let id: Int
    let name: String
    let startDate, endDate: Date
    @DecodableDefault.NoPrize var prize: Prize
    @DecodableDefault.False var lan: Bool
    let liquipedia: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, startDate, endDate, prize, liquipedia, lan
    }
}


// MARK: - EventParticipants
struct EventParticipants: Codable {
    let participants: [Participant]
}

// MARK: - Participant
struct Participant: Codable, Hashable {
    static func == (lhs: Participant, rhs: Participant) -> Bool {
        return lhs.team.id == rhs.team.id
    }
    
    let team: Team
    let players: [PlayerBasic]
    
    enum CodingKeys: String, CodingKey {
        case team
        case players
    }
}


// MARK: - TopPerformers
struct TopPerformers: Codable {
    let stats: [TopPerformer]
}

// MARK: - TopPerformer
struct TopPerformer: Codable {
    let player: PlayerBasic
    let teams: [Team]
    let games: Games
    let stats: Stats
}

// MARK: - Games
struct Games: Codable {
    let total, replays, wins, seconds: Int
    let replaySeconds: Int
}

// MARK: - Stats
struct Stats: Codable {
    let rating: Double
}
