// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let game = try? newJSONDecoder().decode(Game.self, from: jsonData)

import Foundation

// MARK: - Game
struct GameResult: Codable {
    let id: String
    let octaneID: String?
    let number: Int
    let match: MatchSimple
    let map: Map?
    let duration: Int
    let date: String?
    let blue: TeamResult
    let orange: TeamResult
    let ballchasing: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case octaneID = "octane_id"
        case number, match, map, duration, date, blue, orange, ballchasing
    }
}

// MARK: - Ball
struct Ball: Codable {
    let possessionTime, timeInSide: Double
}

// MARK: - Map
struct Map: Codable {
    let id, name: String
}

// MARK: - Match
struct MatchSimple: Codable {
    let id, slug: String
    let event: Event
    let stage: Stage
    let format: Format

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case slug, event, stage, format
    }
}
