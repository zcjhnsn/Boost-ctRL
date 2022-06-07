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
struct Player: Codable {
    @DecodableDefault.EmptyString var id: String
    @DecodableDefault.EmptyString var slug: String
    @DecodableDefault.EmptyString var tag: String
    @DecodableDefault.EmptyString var name: String
    @DecodableDefault.EmptyString var country: String
    @DecodableDefault.EmptyTeam var team: Team
    @DecodableDefault.False var relevant: Bool
    @DecodableDefault.False var coach: Bool
    @DecodableDefault.False var substitute: Bool

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case slug, tag, name, country, team, relevant, coach, substitute
    }
}
