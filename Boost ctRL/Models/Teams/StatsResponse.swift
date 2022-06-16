//
//  StatsResponse.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 6/12/22.
//

import Foundation

// MARK: - StatsResponse
struct StatsResponse: Codable {
    let stats: [StatsObject]
}

// MARK: - Stat
struct StatsObject: Codable {
    let games: Games
    let matches: Matches
    let stats: QueriedStats
}


// MARK: - Matches
struct Matches: Codable {
    let total, replays, wins: Int
}

// MARK: - Stats
struct QueriedStats: Codable {
    @DecodableDefault.Zero var goals: Int
    @DecodableDefault.Zero var goalsAgainst: Int
    @DecodableDefault.ZeroDouble var goalsDifferential: Double
    let inflicted, taken: Int
    @DecodableDefault.ZeroDouble var rating: Double
    @DecodableDefault.ZeroDouble var shootingPercentage: Double
}
