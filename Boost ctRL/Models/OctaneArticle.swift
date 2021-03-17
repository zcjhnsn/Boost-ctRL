//
//  OctaneArticle.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/14/21.
//

import Foundation

struct OctaneArticle: Codable {
    var title: String
    var id: Int
    var url: String
    var image: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case id = "id"
        case url = "hyphenated"
        case image = "Image"
        case description = "Description"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        id = try container.decode(Int.self, forKey: .id)
        url = try container.decode(String.self, forKey: .url)
        url = "https://octane.gg/\(url)"
        image = try container.decode(String.self, forKey: .image)
        description = try container.decode(String.self, forKey: .description)
    }
}

struct OctaneArticles: Codable {
    var data: [OctaneArticle]
}
