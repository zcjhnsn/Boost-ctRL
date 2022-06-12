//
//  SearchList.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 6/6/22.
//

import Foundation

// MARK: - Search
struct SearchList: Codable {
    let searchList: [SearchItem]
}

// MARK: - SearchList
struct SearchItem: Codable {
    let type: SearchType
    let id: String?
    let label: String
    let image: String?
    let groups: [String]?
}

enum SearchType: String, Codable {
    case event
    case player
    case team
}
