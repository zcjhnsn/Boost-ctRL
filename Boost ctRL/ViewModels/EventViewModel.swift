//
//  EventViewModel.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 8/2/21.
//

import Foundation
import Combine

class EventViewModel: ObservableObject {
    @Published var event: EventResult = PreviewHelper.EVENT_RESULT
    @Published var participants: [Participant] = PreviewHelper.MOCK_PARTICIPANTS
    @Published var topPerformers: [TopPerformer] = PreviewHelper.MOCK_TOP_PERFORMERS
    @Published var isEventLoading: Bool = true
    @Published var isParticipantsLoading: Bool = true
    @Published var isTopPerformersLoading: Bool = true
        
    var cancellationToken: AnyCancellable?
    var participantsToken: AnyCancellable?
    var topPerformersToken: AnyCancellable?
    
    init() {
        
    }
    
    /// Retrieves an event given an ID
    /// - Parameter id: Event ID
    func getEvent(byID id: String) {
        isEventLoading = true
        let results = API.getEvent(byID: id)
        
        cancellationToken = results
            .mapError({ error -> Error in
                print("💀 Error - Could not fetch event - \(error)")
                return error
            })
            .sink(receiveCompletion: { _ in
                self.isEventLoading = false
            }, receiveValue: { eventResult in
                self.event = eventResult
            })
    }
    
    /// Retrieves participants in an event
    /// - Parameter id: Event ID
    func getParticipants(forEvent id: String) {
        isParticipantsLoading = true
        let results = API.getParticipants(forEvent: id)
        
        participantsToken = results
            .mapError({ error -> Error in
                print("💀 Error - Could not fetch participants - \(error)")
                return error
            })
            .sink(receiveCompletion: { _ in
                self.isParticipantsLoading = false
            }, receiveValue: { eventParticipants in
                self.participants = eventParticipants.participants
            })
    }
    
    /// Retrieve top performers* for an event.
    /// - Note: *Will return up to 5 participants. If there are less than 5 players in an event, it will return that number of players
    /// - Parameter id: Event
    func getTopPerformers(forEvent id: String) {
        isTopPerformersLoading = true
        let results = API.getTopPerformers(forID: id, idType: .event)
        
        topPerformersToken = results
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
    }
    
}

