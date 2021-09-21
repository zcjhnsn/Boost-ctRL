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
    let prize: Prize
    let tier: String
    let image: String?
    let groups: [String]?
    let stages: [EventStage]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case slug, name, startDate, endDate, region, mode, prize, tier, image, groups, stages
    }
    
    func getRegionName() -> String {
        print(self.region)
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
}

// MARK: - Prize
struct Prize: Codable {
    let amount: Int
    let currency: String
}

// MARK: - Stage
struct EventStage: Codable {
    let id: Int
    let name: String
    let startDate, endDate: Date
    let prize: Prize
    let liquipedia: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, startDate, endDate, prize, liquipedia
    }
}


// MARK: - EventParticipants
struct EventParticipants: Codable {
    let participants: [Participant]
}

// MARK: - Participant
struct Participant: Codable {
    let team: Team
    let players: [Player]
}


// MARK: - TopPerformers
struct TopPerformers: Codable {
    let stats: [TopPerformer]
}

// MARK: - TopPerformer
struct TopPerformer: Codable {
    let player: Player
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

