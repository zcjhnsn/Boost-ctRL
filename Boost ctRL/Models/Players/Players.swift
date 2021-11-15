//
//  Players.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 9/29/21.
//

import Foundation

// MARK: - PlayersResponse
struct PlayersResponse: Decodable {
    let players: [Player]
    let page, perPage, pageSize: Int
}

// MARK: - Player
struct Player: Decodable {
    let id, slug, tag, name: String
    let country: String
    let team: Team
    let relevant, coach, substitute: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case slug, tag, name, country, team, accounts, relevant, coach, substitute
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.slug = try container.decode(String.self, forKey: .slug)
        self.tag = try container.decode(String.self, forKey: .tag)
        self.name = try container.decode(String.self, forKey: .name)
        self.country = try container.decode(String.self, forKey: .country)
        self.team = try container.decode(Team.self, forKey: .team)
        self.relevant = try container.decodeIfPresent(Bool.self, forKey: .relevant) ?? false
        self.coach = try container.decodeIfPresent(Bool.self, forKey: .coach) ?? false
        self.substitute = try container.decodeIfPresent(Bool.self, forKey: .substitute) ?? false
    }
}

