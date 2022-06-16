//
//  PlayerViewModel.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 6/13/22.
//

import Foundation
import Combine
import Collections

struct PlayerRecord {
    var seriesWon: Int = 0
    var seriesTotal: Int = 0
    var gamesWon: Int = 0
    var gamesTotal: Int = 0
    var goals: Int = 0
    var shotPercentage: Double = 0.0
    var demosFor: Int = 0
    var demosAgainst: Int = 0
    var ratingTotal: Double = 0.0
    
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
    
    var goalsPerGame: Double {
        guard gamesTotal != 0 else { return 0.0 }
        return Double(goals) / Double(gamesTotal)
    }
    
    var demosInflictedPerGame: Double {
        guard gamesTotal > 0 else {
            return 0.0
        }
        
        return Double(demosFor) / Double(gamesTotal)
    }
    
    var demosTakenPerGame: Double {
        guard gamesTotal > 0 else {
            return 0.0
        }
        
        return Double(demosAgainst) / Double(gamesTotal)
    }
    
    var rating: Double {
        guard gamesTotal != 0 else { return 0.0 }
        return ratingTotal / Double(gamesTotal)
    }
}

class PlayerViewModel: ObservableObject {
    @Published var teammates: [Player] = Array(repeating: ExampleData.player, count: 3)
    @Published var matchesLast3Months: [Match] = Array(repeating: ExampleData.match, count: 3)
    @Published var player: Player = ExampleData.player
    
    @Published var isPlayersLoading: Bool = true
    @Published var isPlayerLoading: Bool = true
    @Published var isStatsLoading: Bool = true
    @Published var isTopPerformersLoading: Bool = true
    @Published var isEventMatchesLoading: Bool = true
    @Published var record: PlayerRecord = PlayerRecord()
        
    var subscriptions = [AnyCancellable]()
    
    init() {
        
    }
    
    func getPlayerInfo(playerId: String) {
        self.isPlayerLoading = true
        API.getPlayer(playerId)
            .mapError { error -> Error in
                print("💀 Error - Could not fetch player: \(playerId) - \(error)")
                return error
            }
            .sink { _ in
                self.isPlayerLoading = false
            } receiveValue: { playerResponse in
                self.player = playerResponse
                self.getPlayers(forTeam: playerResponse.team.slug)
            }
            .store(in: &subscriptions)
            
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
                self.teammates = playerResponse.players.sorted { (lhs, rhs) in
                    let predicates: [SortedByRole] = [
                        // swiftlint:disable opening_brace
                        { !$0.coach && $1.coach },
                        { (!$0.substitute && $1.substitute) && (!$0.coach && $1.coach) },
                        { $0.tag < $1.tag },
                        { !$0.substitute && $1.substitute }
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
    
    func getPlayerStats(playerID: String) {
        isStatsLoading = true
        
        API.getStats(forPlayer: playerID)
            .mapError({ error -> Error in
                print("💀 Error - Could not fetch team stats - \(error)")
                return error
            })
            .sink(receiveCompletion: { _ in
                self.isStatsLoading = false
            }, receiveValue: { statsResult in
                guard let result = statsResult.stats.first else { return }
                self.record = PlayerRecord(seriesWon: result.matches.wins, seriesTotal: result.matches.total, gamesWon: result.games.wins, gamesTotal: result.games.total, goals: result.stats.goals, shotPercentage: result.stats.shootingPercentage, demosFor: result.stats.inflicted, demosAgainst: result.stats.taken, ratingTotal: result.stats.rating)
            })
            .store(in: &subscriptions)
    }
    
}
