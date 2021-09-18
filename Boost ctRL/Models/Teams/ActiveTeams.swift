//
//  ActiveTeams.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 9/16/21.
//

import Foundation

// MARK: - ActiveTeams
struct ActiveTeamsResponse: Codable {
    let teams: [ActiveTeam]
}

// MARK: - TeamElement
struct ActiveTeam: Codable {
    let team: ActiveTeamInfo
    let players: [ActivePlayer]
}

// MARK: - Player
struct ActivePlayer: Codable {
    let id, slug, tag: String
    private(set) var name: String?
    let country: String?
    let team: ActiveTeamInfo
    private(set) var relevant: Bool? = false
    private(set) var coach: Bool? = false
    private(set) var substitute: Bool? = false

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case slug, tag, name, country, team, relevant, coach
    }
}


// MARK: - ActiveTeamInfo
struct ActiveTeamInfo: Codable {
    let id, slug, name: String
    let region: Region?
    let image: String?
    let relevant: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case slug, name, region, image, relevant
    }
}

enum Region: String, Codable, CaseIterable {
    case all = "ALL"
    case asia = "ASIA"
    case eu = "EU"
    case me = "ME"
    case na = "NA"
    case oce = "OCE"
    case sam = "SAM"
}
