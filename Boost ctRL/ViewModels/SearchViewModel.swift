//
//  SearchViewModel.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 6/6/22.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchItems: [SearchItem] = []
    @Published var searchText: String = ""
    @Published var isSearchListLoading: Bool = true
    @Published var filteredSearchItems: [SearchItem] = []
        
    var subscriptions = [AnyCancellable]()
    var publisher: AnyCancellable?
    
    init() {
        self.getSearchItems()
        self.publisher = $searchText
            .receive(on: RunLoop.main)
            .sink(receiveValue: { (str) in
                if !self.searchText.isEmpty {
                    self.filteredSearchItems = self.searchItems.filter { $0.label.lowercased().contains(str.lowercased()) }.sorted(by: { $0.label < $1.label })
                } else {
                    self.filteredSearchItems = self.searchItems
                }
            })
    }
     
    /// Retrieves search items
    func getSearchItems() {
        isSearchListLoading = true
        API.getSearchList()
            .mapError({ error -> Error in
                print("💀 Error - Could not fetch completed events - \(error)")
                return error
            })
            .sink(receiveCompletion: { _ in
                self.isSearchListLoading = false
            }, receiveValue: { retrievedList in
                self.searchItems = retrievedList.searchList
                self.filteredSearchItems = self.searchItems
            })
            .store(in: &subscriptions)
    }
}
