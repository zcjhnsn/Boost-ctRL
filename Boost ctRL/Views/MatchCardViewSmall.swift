//
//  MatchCardViewSmall.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 6/23/21.
//

import SwiftUI



struct MatchCardViewSmall: View {
    var match: Match
    var inProgress: Bool {
        if !match.blue.winner && !match.orange.winner {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        NavigationLink(destination:
                        MatchResultView(match: match)
                            .navigationTitle("Match Overview")
                
        ) {
            
            VStack(alignment: .leading) {
                GeometryReader { geo in
                    VStack(alignment: .leading, spacing: 8, content: {
                        
                        HStack {
                            
                            VStack(spacing: 6) {
                                
                                Text(match.event.name)
                                    .font(.system(.footnote, design: .rounded))
                                    .padding([.horizontal, .top], 12)
                                    .frame(width: 220,alignment: .leading)
                                
                                TeamScoreRowSmall(teamResult: match.blue, isInProgress: inProgress)
                                
                                
                                TeamScoreRowSmall(teamResult: match.orange, isInProgress: inProgress)
                                    .padding([.bottom], 12)
                            }
                        }
                        
                    })
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .top)
                    
                }
            }
            .background(Color(UIColor.secondarySystemBackground))
            .frame(width: 220, height: 90, alignment: .topLeading)
            .cornerRadius(8, corners: .allCorners)
            .padding(.leading, 15)
            .padding(.vertical, 4)
            
            
        }
        
    }
}

struct MatchCardViewSmall_Previews: PreviewProvider {
    static var previews: some View {
        MatchCardViewSmall(match: Match(
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
                                winner: false
                            ),
                            number: 1,
                            games: nil))
            .preferredColorScheme(.dark)
        
    }
}

