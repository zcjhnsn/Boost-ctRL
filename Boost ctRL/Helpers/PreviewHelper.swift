//
//  PreviewHelper.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/6/21.
//

import Foundation

struct ExampleData {
    static func fromJson<T: Codable>(name: String) -> T {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        let data = try! Data(contentsOf: Bundle.main.url(forResource: name, withExtension: "json")!)
        return try! jsonDecoder.decode(T.self, from: data)
    }
    
    static var team: Team {
        fromJson(name: "Team")
    }
    
    static var match: Match {
        fromJson(name: "Match")
    }
    
    static var player: Player {
        fromJson(name: "Player")
    }
    
    static var topPerformers: [TopPerformer] {
        fromJson(name: "TopPerformers")
    }
    
    static var event: Event {
        fromJson(name: "EventResult")
    }
    
    static var eventResult: EventResult {
        fromJson(name: "EventResult")
    }
    
    static var activeTeam: ActiveTeam {
        fromJson(name: "ActiveTeam")
    }
    
    static var participants: [Participant] {
        fromJson(name: "Participants")
    }
    
    static var teamResult: TeamResult {
        TeamResult(score: 3, teamInfo: TeamInfo(team: team, stats: nil), players: [], winner: false)
    }
}

extension Decodable {
    init(data: Data, using decoder: JSONDecoder = .init()) throws {
        self = try decoder.decode(Self.self, from: data)
    }
    init(json: String, using decoder: JSONDecoder = .init()) throws {
        try self.init(data: Data(json.utf8), using: decoder)
    }
}
