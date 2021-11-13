//
//  RecentResultsRowView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/1/21.
//

import SwiftUI

struct RecentResultsRowView: View {
    var recentMatches: [Match]
    
    var body: some View {

        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(recentMatches) { m in
                        MatchCardView(match: m, viewSize: .small)
                    }
                }
            }
            .padding(.bottom, 6)
        }
    }
}

struct RecentResultsRowView_Previews: PreviewProvider {
    static var previews: some View {
        RecentResultsRowView(recentMatches: [
            Match(
                id: "123123123",
                slug: "123123",
                event: Event(id: "123", slug: "123", name: "RLCS XI Fall Major", region: "na", mode: 3, tier: "S", image: "https://griffon.octane.gg/events/rlcs-x-championships.png", groups: ["rlcsxi"]),
                stage: Stage(id: 123, name: "asdf"),
                date: "",
                format: Format(type: "best", length: 3),
                blue: TeamResult(
                    score: 3,
                    teamInfo: TeamInfo(team: Team(
                            id: "1",
                            slug: "nrg",
                            name: "NRG Esports",
                            image: "https://griffon.octane.gg/teams/nrg-esports.png"
                        ),
                        stats: nil
                    ),
                    players: [
                        PlayerResult(
                            player: Player(
                                id: "gg",
                                slug: "garrettg",
                                tag: "GarrettG",
                                country: "us"
                            ),
                            stats: nil,
                            advanced: nil
                        ),
                        PlayerResult(
                            player: Player(
                                id: "gg",
                                slug: "garrettg",
                                tag: "GarrettG",
                                country: "us"
                            ),
                            stats: nil,
                            advanced: nil
                        ),
                        PlayerResult(
                            player: Player(
                                id: "gg",
                                slug: "garrettg",
                                tag: "GarrettG",
                                country: "us"
                            ),
                            stats: nil,
                            advanced: nil
                        )
                    ],
                    winner: true
                ),
                orange: TeamResult(
                    score: 3,
                    teamInfo: TeamInfo(team: Team(
                            id: "1",
                            slug: "nrg",
                            name: "NRG Esports",
                            image: "https://griffon.octane.gg/teams/nrg-esports.png"
                        ),
                        stats: nil
                    ),
                    players: [
                        PlayerResult(
                            player: Player(
                                id: "gg",
                                slug: "garrettg",
                                tag: "GarrettG",
                                country: "us"
                            ),
                            stats: nil,
                            advanced: nil
                        ),
                        PlayerResult(
                            player: Player(
                                id: "gg",
                                slug: "garrettg",
                                tag: "GarrettG",
                                country: "us"
                            ),
                            stats: nil,
                            advanced: nil
                        ),
                        PlayerResult(
                            player: Player(
                                id: "gg",
                                slug: "garrettg",
                                tag: "GarrettG",
                                country: "us"
                            ),
                            stats: nil,
                            advanced: nil
                        )
                    ],
                    winner: true
                ),
                number: 1,
                games: nil)
        ])
    }
}
