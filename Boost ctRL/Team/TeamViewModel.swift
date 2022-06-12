//
//  TeamViewModel.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 6/8/22.
//

import Foundation
import Combine
import Collections

typealias SortedByRole = (Player, Player) -> Bool

struct PlayerResponse: Codable {
    let players: [Player]
    let page, perPage, pageSize: Int?
}

struct TeamRecord {
    var seriesWon: Int = 0
    var seriesTotal: Int = 0
    var gamesWon: Int = 0
    var gamesTotal: Int = 0
    var goalsFor: Int = 0
    var goalsAgainst: Int = 0
    var goalsDifferential: Int = 0
    var demosFor: Int = 0
    var demosAgainst: Int = 0
    var overtimeWin: Int = 0
    var overtimeTotal: Int = 0
    
    var seriesLost: Int {
        seriesTotal - seriesWon
    }
    
    var seriesPercentage: Double {
        guard seriesTotal != 0 else { return 0.0 }
        return Double(seriesWon) / Double(seriesTotal)
    }
    
    var gamesLost: Int {
        gamesTotal - gamesWon
    }
    
    var gamesPercentage: Double {
        guard gamesTotal != 0 else { return 0.0 }
        return Double(gamesWon) / Double(gamesTotal)
    }
    
    var goalsPercentage: Double {
        guard goalsAgainst + goalsFor != 0 else { return 0.0 }
        return Double(goalsFor) / Double(goalsFor + goalsAgainst)
    }
    
    var demosPercentage: Double {
        guard demosFor + demosAgainst != 0 else { return 0.0 }
        return Double(demosFor) / Double(demosFor + demosAgainst)
    }
    
    var overtimePercentage: Double {
        guard overtimeTotal != 0 else { return 0.0 }
        return Double(overtimeWin) / Double(overtimeTotal)
    }
    
    var overtimeLosses: Int {
        overtimeTotal - overtimeWin
    }
}

class TeamViewModel: ObservableObject {
    @Published var players: [Player] = Array(repeating: ExampleData.player, count: 3)
    @Published var matchesLast3Months: [Match] = Array(repeating: ExampleData.match, count: 3)
    
    @Published var isPlayersLoading: Bool = true
    @Published var isStatsLoading: Bool = true
    @Published var isTopPerformersLoading: Bool = true
    @Published var isEventMatchesLoading: Bool = true
    @Published var teamRecord: TeamRecord = TeamRecord()
        
    var subscriptions = [AnyCancellable]()
    
    init() {
        
    }
    
    func getPlayers(forTeam teamID: String) {
        isPlayersLoading = true
        
        API.getPlayers(teamID: teamID)
            .mapError { error -> Error in
                print("💀 Error - Could not fetch players for teamID: \(teamID) - \(error)")
                return error
            }
            .sink { _ in
                self.isPlayersLoading = false
            } receiveValue: { playerResponse in
                self.players = playerResponse.players.sorted { (lhs, rhs) in
                    let predicates: [SortedByRole] = [
                        // swiftlint:disable opening_brace
                        
                        { !$0.coach && $1.coach },
                        { (!$0.substitute && $1.substitute) && (!$0.coach && $1.coach) },
                        { $0.tag < $1.tag },
                        { !$0.substitute && $1.substitute },
                        // swiftlint:enable opening_brace
                    ]
                    
                    for predicate in predicates {
                        if !predicate(lhs, rhs) && !predicate(rhs, lhs) { // <4>
                            continue // <5>
                        }
                        
                        return predicate(lhs, rhs) // <5>
                    }
                    
                    return false

                }
            }
            .store(in: &subscriptions)
    }
    
    /// Retrieves matches in last 3 months for a team
    /// - Parameter id: Team ID
    func getMatches(forTeam id: String) {
        isStatsLoading = true
        
        API.getMatches(teamID: id)
            .mapError({ error -> Error in
                print("💀 Error - Could not fetch matches for team \(id) - \(error)")
                return error
            })
            .sink(receiveCompletion: { _ in
                self.isStatsLoading = false
            }, receiveValue: { matchResponse in
                self.matchesLast3Months = matchResponse.matches
                self.getTeamStats(teamID: id)
            })
            .store(in: &subscriptions)
    }
    
    func getTeamStats(teamID: String) {
        isStatsLoading = true
        
        Publishers.Zip(API.getStats(for: teamID), API.getStats(for: teamID, isOvertime: true))
            .mapError({ error -> Error in
                print("💀 Error - Could not fetch team stats - \(error)")
                return error
            })
            .compactMap { responses -> (StatsObject, StatsObject) in
                guard let regularTime = responses.0.stats.first, let overtime = responses.1.stats.first else {
                    return (StatsObject(games: Games(total: 0, replays: 0, wins: 0, seconds: 0, replaySeconds: 0), matches: Matches(total: 0, replays: 0, wins: 0), stats: QueriedStats(goals: 0, goalsAgainst: 0, goalsDifferential: 0.0, inflicted: 0, taken: 0)), StatsObject(games: Games(total: 0, replays: 0, wins: 0, seconds: 0, replaySeconds: 0), matches: Matches(total: 0, replays: 0, wins: 0), stats: QueriedStats(goals: 0, goalsAgainst: 0, goalsDifferential: 0.0, inflicted: 0, taken: 0)))
                }
                return (regularTime, overtime)
            }
            .sink(receiveCompletion: { _ in
                self.isStatsLoading = false
            }, receiveValue: { statsResult in
                self.teamRecord = TeamRecord(
                    seriesWon: statsResult.0.matches.wins,
                    seriesTotal: statsResult.0.matches.total,
                    gamesWon: statsResult.0.games.wins,
                    gamesTotal: statsResult.0.games.total,
                    goalsFor: statsResult.0.stats.goals,
                    goalsAgainst: statsResult.0.stats.goalsAgainst,
                    goalsDifferential: Int(round(statsResult.0.stats.goalsDifferential)),
                    demosFor: statsResult.0.stats.inflicted,
                    demosAgainst: statsResult.0.stats.taken,
                    overtimeWin: statsResult.1.games.wins,
                    overtimeTotal: statsResult.1.games.total
                )
            })
            .store(in: &subscriptions)
    }
    
}

func getRecord(from matches: [Match], teamID: String) -> TeamRecord {
    var teamRecord = TeamRecord()
    teamRecord.seriesTotal = matches.count
    
    for match in matches {
        teamRecord.gamesTotal += (match.blue.score + match.orange.score)
        
        if match.blue.teamInfo.team.isSameTeam(as: teamID) {
            if match.blue.winner {
                teamRecord.seriesWon += 1
            }
            
            teamRecord.gamesWon += match.blue.score
            
            teamRecord.goalsFor += match.blue.teamInfo.stats?.core.goals ?? 0
            teamRecord.goalsAgainst += match.orange.teamInfo.stats?.core.goals ?? 0
            
            teamRecord.demosFor += match.blue.teamInfo.stats?.demo.inflicted ?? 0
            teamRecord.demosAgainst += match.blue.teamInfo.stats?.demo.taken ?? 0
            
            for game in match.games {
                teamRecord.overtimeTotal += game.overtime ? 1 : 0
                teamRecord.overtimeWin += game.overtime && game.blue > game.orange ? 1 : 0
            }
                
        } else if match.orange.teamInfo.team.isSameTeam(as: teamID) && match.orange.winner  {
            if match.orange.winner {
                teamRecord.seriesWon += 1
            }
            
            teamRecord.gamesWon += match.orange.score
            
            teamRecord.goalsFor += match.orange.teamInfo.stats?.core.goals ?? 0
            teamRecord.goalsAgainst += match.blue.teamInfo.stats?.core.goals ?? 0
            
            teamRecord.demosFor += match.orange.teamInfo.stats?.demo.inflicted ?? 0
            teamRecord.demosAgainst += match.orange.teamInfo.stats?.demo.taken ?? 0
            
            for game in match.games {
                teamRecord.overtimeTotal += game.overtime ? 1 : 0
                teamRecord.overtimeWin += game.overtime && game.orange > game.blue ? 1 : 0
            }
        }
    }
    
    return teamRecord
}
