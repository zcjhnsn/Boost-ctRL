//
//  EventListViewModel.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 2/5/22.
//

import Foundation
import Combine

class EventListViewModel: ObservableObject {
    @Published var eventsCompleted: [Event] = []
    @Published var eventsFuture: [Event] = []
    @Published var searchText: String = ""
    @Published var isCompletedEventsLoading: Bool = true
    @Published var isFutureEventsLoading: Bool = true
    @Published var filteredCompleted: [Event] = []
    @Published var filteredFuture: [Event] = []
        
    var subscriptions = [AnyCancellable]()
    var publisher: AnyCancellable?
    
    init() {
        self.getCompletedEvents()
        self.getFutureEvents()
        self.publisher = $searchText
            .receive(on: RunLoop.main)
            .sink(receiveValue: { (str) in
                if !self.searchText.isEmpty {
                    self.filteredCompleted = self.eventsCompleted.filter { $0.name.lowercased().contains(str.lowercased()) }
                    self.filteredFuture = self.eventsFuture.filter { $0.name.lowercased().contains(str.lowercased()) }
                } else {
                    self.filteredCompleted = self.eventsCompleted
                    self.filteredFuture = self.eventsFuture
                }
            })
    }
    
    /// Retrieves completed events
    func getCompletedEvents() {
        isCompletedEventsLoading = true
        API.getEvents(status: .completed)
            .mapError({ error -> Error in
                print("💀 Error - Could not fetch completed events - \(error)")
                return error
            })
            .sink(receiveCompletion: { _ in
                self.isCompletedEventsLoading = false
            }, receiveValue: { completedEventsResult in
                self.eventsCompleted = completedEventsResult.events.sorted(by: { $0.endDate ?? Date.today > $1.endDate ?? Date.today })
                self.filteredCompleted = self.eventsCompleted
            })
            .store(in: &subscriptions)
    }
    
    /// Retrieves future/ongoing events
    func getFutureEvents() {
        isFutureEventsLoading = true
        Publishers.Zip(API.getEvents(status: .ongoing), API.getEvents(status: .upcoming))
            .mapError({ error -> Error in
                print("💀 Error - Could not fetch future events - \(error)")
                return error
            })
            .map { response -> [Event] in
                return (response.0.events + response.1.events)
            }
            .sink(receiveCompletion: { _ in
                self.isFutureEventsLoading = false
            }, receiveValue: { futureEventsResult in
                self.eventsFuture = Array(Set(futureEventsResult)).sorted { $0.startDate ?? Date() < $1.startDate ?? Date() }.sorted { $0.tier > $1.tier }
                self.filteredFuture = self.eventsFuture
            })
            .store(in: &subscriptions)
    }
}
