//
//  PreviewHelper.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/6/21.
//

import Foundation

struct PreviewHelper {
    
    static let DATE: String = "2021-06-20T19:00:00Z"
    
    static let TEAM_RESULT_NA_1: TeamResult = TeamResult(
        score: 3,
        teamInfo: MOCK_TEAM_INFO_NA_1,
        players: [
            PLAYER_RESULT,
            PLAYER_RESULT,
            PLAYER_RESULT
        ],
        winner: true
    )
    
    static let PLAYER_RESULT: PlayerResult = PlayerResult(
        player: PLAYER,
        stats: nil,
        advanced: nil
    )
    
    static let PLAYER: Player = Player(
        id: "gg",
        slug: "garrettg",
        tag: "GarrettG",
        country: "us"
    )
    
    static let MOCK_TEAM_INFO_NA_1: TeamInfo = TeamInfo(team: MOCK_TEAM_NA_1, stats: nil)
    
    static let MOCK_TEAM_NA_1: Team = Team(
        id: "1",
        slug: "nrg",
        name: "NRG Esports",
        image: "https://griffon.octane.gg/teams/nrg-esports.png"
    )
    
    static let FORMAT = Format(type: "best", length: 3)
    
    static let EVENT = Event(id: "123", slug: "123", name: "RLCS XI Fall Major", region: "na", mode: 3, tier: "S", image: "https://griffon.octane.gg/events/rlcs-x-championships.png", groups: ["rlcsxi"])
    
    static let STAGE = Stage(id: 123, name: "asdf")
    
    static let MATCH = Match(
        id: "123123123",
        slug: "123123",
        event: EVENT,
        stage: STAGE,
        date: DATE,
        format: FORMAT,
        blue: TeamResult(
            score: 3,
            teamInfo: MOCK_TEAM_INFO_NA_1,
            players: [
                PLAYER_RESULT,
                PLAYER_RESULT,
                PLAYER_RESULT
            ],
            winner: true
        ),
        orange: TeamResult(
            score: 2,
            teamInfo: TeamInfo(team: Team(
                id: "1",
                slug: "nrg",
                name: "NRG Esports",
                image: "https://griffon.octane.gg/teams/nrg-esports.png"
            ),
            stats: nil
            ),
            players: [
                PLAYER_RESULT,
                PLAYER_RESULT,
                PLAYER_RESULT
            ],
            winner: false
        ),
        number: 1,
        games: nil)
}
