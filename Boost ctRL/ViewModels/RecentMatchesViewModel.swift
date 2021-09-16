//
//  RecentMatchesViewModel.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 6/25/21.
//

import Foundation
import Combine

class RecentMatchesViewModel: ObservableObject {
    @Published var matches: [Match] = []
    @Published var isMatchesLoading: Bool = true
    let dummyData = [
        PreviewHelper.MATCH,
        PreviewHelper.MATCH,
        PreviewHelper.MATCH,
        PreviewHelper.MATCH,
        PreviewHelper.MATCH,
        PreviewHelper.MATCH,
        PreviewHelper.MATCH,
        PreviewHelper.MATCH,
        PreviewHelper.MATCH,
        PreviewHelper.MATCH,
        PreviewHelper.MATCH
    ]
    
    var cancellationToken: AnyCancellable?
    
    init() {
        getMatches()
    }
    
    /// Retrieves the 10 most recent ongoing/completed matches
    private func getMatches() {
        isMatchesLoading = true
        let results = API.getRecentMatches()
        
        cancellationToken = results
            .mapError({ error -> Error in
                print("💀 Error - Could not fetch recent matches - \(error) ")
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { matchResults in
                    self.matches = matchResults.matches
                    self.isMatchesLoading = false
                  })
    }
    
}
