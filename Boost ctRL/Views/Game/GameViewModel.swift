//
//  GameViewModel.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/27/22.
//

import Foundation
import Combine

class GameViewModel: ObservableObject {
    @Published var game: GameResult = ExampleData.game
    @Published var topPerformers: [TopPerformer] = []
    @Published var isGameLoading: Bool = true
        
    var subscriptions = [AnyCancellable]()
    
    init() { }
    
    /// Retrieves an event given an ID
    /// - Parameter id: Event ID
    func getGame(byID id: String) {
        isGameLoading = true
        API.getGame(id)
            .mapError({ error -> Error in
                print("💀 Error - Could not fetch event - \(error)")
                return error
            })
            .sink(receiveCompletion: { _ in
                self.isGameLoading = false
            }, receiveValue: { gameResult in
                    self.game = gameResult
                let bluePlayers = gameResult.blue.players
                let bluePerformers: [TopPerformer] = bluePlayers.compactMap {
                    let stats = Stats(rating: $0.advanced?.rating ?? 0)
                    let game = Games(total: 1, replays: 0, wins: 0, seconds: 0, replaySeconds: 0)
                    
                    let tp = TopPerformer(player: $0.player,
                                          teams: [gameResult.blue.teamInfo.team], games: game, stats: stats)
                    return tp
                }
                
                let orangePlayers = gameResult.orange.players
                let orangePerformers: [TopPerformer] = orangePlayers.compactMap {
                    let stats = Stats(rating: $0.advanced?.rating ?? 0)
                    let game = Games(total: 1, replays: 0, wins: 0, seconds: 0, replaySeconds: 0)
                    
                    let tp = TopPerformer(player: $0.player,
                                          teams: [gameResult.orange.teamInfo.team], games: game, stats: stats)
                    return tp
                }
                let players = bluePerformers + orangePerformers
                
                self.topPerformers = Array(players.sorted { $0.stats.rating > $1.stats.rating }.prefix(5))
            })
            .store(in: &subscriptions)
    }
    
}
