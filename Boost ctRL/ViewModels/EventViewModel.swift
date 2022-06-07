//
//  EventViewModel.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 8/2/21.
//

import Foundation
import Combine
import Collections

class EventViewModel: ObservableObject {
    @Published var event: EventResult = ExampleData.eventResult
    @Published var participants: [Participant] = ExampleData.participants
    @Published var topPerformers: [TopPerformer] = ExampleData.topPerformers
    @Published var eventMatches: OrderedDictionary<DateComponents, [Match]> = [DateComponents(year: 2021, month: 9, day: 23): [ ExampleData.match, ExampleData.match, ExampleData.match ]]
    
    @Published var isEventLoading: Bool = true
    @Published var isParticipantsLoading: Bool = true
    @Published var isTopPerformersLoading: Bool = true
    @Published var isEventMatchesLoading: Bool = true
        
    var subscriptions = [AnyCancellable]()
    
    init() {
        
    }
    
    /// Retrieves an event given an ID
    /// - Parameter id: Event ID
    func getEvent(byID id: String) {
        isEventLoading = true
        
        API.getEvent(byID: id)
            .mapError({ error -> Error in
                print("💀 Error - Could not fetch event ID: \(id) - \(error)")
                return error
            })
            .sink(receiveCompletion: { _ in
                self.isEventLoading = false
            }, receiveValue: { eventResult in
                self.event = eventResult
            })
            .store(in: &subscriptions)
    }
    
    /// Retrieves participants in an event
    /// - Parameter id: Event ID
    func getParticipants(forEvent id: String) {
        isParticipantsLoading = true
        
        API.getParticipants(forEvent: id)
            .mapError({ error -> Error in
                print("💀 Error - Could not fetch participants - \(error)")
                return error
            })
            .sink(receiveCompletion: { _ in
                self.isParticipantsLoading = false
            }, receiveValue: { eventParticipants in
                self.participants = eventParticipants.participants
            })
            .store(in: &subscriptions)
    }
    
    /// Retrieve top performers* for an event.
    /// - Note: *Will return up to 5 participants. If there are less than 5 players in an event, it will return that number of players
    /// - Parameter id: Event
    func getTopPerformers(forEvent id: String) {
        isTopPerformersLoading = true
        
        API.getTopPerformers(forID: id, idType: .event)
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
    
    func getMatches(forEvent id: String) {
        isEventMatchesLoading = true
        
        API.getMatches(forEvent: id)
            .mapError({ error -> Error in
                print("💀 Error - Could not fetch event matches - \(error)")
                return error
            })
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { response in
                
                self.eventMatches = self.groupMatchesByDate(response.matches)
                self.isEventMatchesLoading = false
            })
            .store(in: &subscriptions)
    }
    
    /// Group array of matches by date. Uses new `OrderedDictionary` from `Collections` library.
    /// - Parameter matches: Array of matches
    /// - Returns: Ordered Dictionary of matches keyed by Year/Month/Day components
    private func groupMatchesByDate(_ matches: [Match]) -> OrderedDictionary<DateComponents, [Match]> {
        // Date formatter to convert ISO8601 time to local time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        
        let sortedMatches = matches.sorted(by: { $0.date > $1.date })
        
        // New `OrderedDictionary` from the `Collections` library 🥳
        // Dictionary keys look like -> year: 2021 month: 6 day: 20 isLeapMonth: false
        let orderedDict = OrderedDictionary<DateComponents, [Match]>(grouping: sortedMatches) { match in
            let date = dateFormatter.date(from: match.date) ?? Date()
            let components = Calendar.current.dateComponents([.day, .year, .month], from: date)
            return components
        }
        
        return orderedDict
    }
}
