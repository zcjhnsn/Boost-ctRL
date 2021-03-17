//
//  Article.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/13/21.
//

import Foundation

struct Article: Identifiable, Hashable, Codable {
    var id: Int
    var image: String
    var link: String
    var title: String
    
    var newsSource: NewsSource {
        return link.lowercased().contains(NewsSource.rocketeers.rawValue.lowercased()) ? .rocketeers : .octane
    }
}

enum NewsSource: String, CaseIterable, Codable {
    case octane = "Octane.gg"
    case rocketeers = "Rocketeers.gg"
    
    static func allValues() -> [NewsSource] {
        return [.rocketeers, .octane]
    }
}
