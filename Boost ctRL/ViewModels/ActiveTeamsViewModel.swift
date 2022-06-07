//
//  ActiveTeamsViewModel.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 9/16/21.
//

import Foundation
import Combine

class ActiveTeamsViewModel: ObservableObject {
    @Published var teams: [ActiveTeam] = [ ExampleData.activeTeam, ExampleData.activeTeam, ExampleData.activeTeam, ExampleData.activeTeam ]
    @Published var searchText: String = ""
    @Published var isTeamsLoading: Bool = true
    @Published var filteredData: [ActiveTeam] = []
        
    var subscriptions = [AnyCancellable]()
    var publisher: AnyCancellable?
    
    init() {
        self.filteredData = teams
        self.publisher = $searchText
            .receive(on: RunLoop.main)
            .sink(receiveValue: { (str) in
                if !self.searchText.isEmpty {
                    self.filteredData = self.teams.filter { $0.team.name.lowercased().contains(str.lowercased()) }
                } else {
                    self.filteredData = self.teams
                }
            })
    }
    
    /// Retrieves an event given an ID
    /// - Parameter id: Event ID
    func getTeams() {
        isTeamsLoading = true
        API.getActiveTeams()
            .mapError({ error -> Error in
                print("💀 Error - Could not fetch active teams - \(error)")
                return error
            })
            .sink(receiveCompletion: { _ in
                self.isTeamsLoading = false
            }, receiveValue: { activeTeamsResult in
                self.teams = activeTeamsResult.teams.sorted(by: { $0.team.name.lowercased() < $1.team.name.lowercased() })
                self.filteredData = self.teams
            })
            .store(in: &subscriptions)
    }
}
