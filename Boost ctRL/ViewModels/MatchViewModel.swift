//
//  MatchViewModel.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 9/21/21.
//

import Foundation
import Combine

class MatchViewModel: ObservableObject {
    @Published var match: Match = PreviewHelper.MATCH
    @Published var participants: [Participant] = PreviewHelper.MOCK_PARTICIPANTS
    @Published var topPerformers: [TopPerformer] = PreviewHelper.MOCK_TOP_PERFORMERS
    @Published var isMatchLoading: Bool = true
    @Published var isParticipantsLoading: Bool = true
    @Published var isTopPerformersLoading: Bool = true
        
    var subscriptions = [AnyCancellable]()
    
    init() {
        
    }
    
//    /// Retrieves an event given an ID
//    /// - Parameter id: Event ID
//    func getMatch(byID id: String) {
//        isMatchLoading = true
//        let results = API.getEvent(byID: id)
//
//        cancellationToken = results
//            .mapError({ error -> Error in
//                print("💀 Error - Could not fetch event - \(error)")
//                return error
//            })
//            .sink(receiveCompletion: { _ in
//                self.isEventLoading = false
//            }, receiveValue: { eventResult in
//                    self.event = eventResult
//            })
//    }

    
    /// Retrieve top performers* for an event.
    /// - Note: *Will return up to 5 participants. If there are less than 5 players in an event, it will return that number of players
    /// - Parameter id: Match ID/Slug
    func getTopPerformers(forMatch id: String) {
        isTopPerformersLoading = true
        
        API.getTopPerformers(forID: id, idType: .match)
            .mapError({ error -> Error in
                print("💀 Error - Could not fetch top participants - \(error)")
                return error
            })
            .sink(receiveCompletion: { _ in
            }, receiveValue: { performers in
                let sortedPerformers = performers.stats.sorted(by: { $0.stats.rating/Double($0.games.total) > $1.stats.rating/Double($1.games.total) })
                
                self.topPerformers = Array(sortedPerformers.prefix(5))
                self.isTopPerformersLoading = false
            })
            .store(in: &subscriptions)
    }
    
}
