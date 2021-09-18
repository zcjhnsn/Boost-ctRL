//
//  ActiveTeamsViewModel.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 9/16/21.
//

import Foundation
import Combine

class ActiveTeamsViewModel: ObservableObject {
    @Published var teams: [ActiveTeam] = PreviewHelper.MOCK_ACTIVE_TEAM_RESPONSE.teams
    @Published var searchText: String = ""
    @Published var isTeamsLoading: Bool = true
    
        
    var cancellationToken: AnyCancellable?
    var filteredData: [ActiveTeam] = []
    var publisher: AnyCancellable?
    
    init() {
        self.filteredData = teams
        self.publisher = $searchText
            .receive(on: RunLoop.main)
            .sink(receiveValue: { (str) in
                if !self.searchText.isEmpty {
                    self.filteredData = self.teams.filter { $0.team.name.contains(str) }
                } else {
                    self.filteredData = self.teams
                }
            })
    }
    
    /// Retrieves an event given an ID
    /// - Parameter id: Event ID
    func getTeams() {
        isTeamsLoading = true
        let results = API.getActiveTeams()
        
        cancellationToken = results
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
    }
    

    
}

