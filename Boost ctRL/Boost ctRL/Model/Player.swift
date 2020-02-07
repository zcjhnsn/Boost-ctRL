//
//  Player.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 2/5/20.
//  Copyright © 2020 Zac Johnson. All rights reserved.
//

import Foundation
import CloudKit

class Player: NSObject {
    var recordID: CKRecord.ID!
    var id: String!
    var twitchName: String!
    var viewers: Int = 0
}

struct Streamer: Codable {
	var userName: String
	var title: String
    var viewers: Int
    
    enum CodingKeys: String, CodingKey {
		case userName = "user_name"
        case viewers = "viewer_count"
		case title = "title"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
		viewers = try container.decode(Int.self, forKey: .viewers)
		userName = try container.decode(String.self, forKey: .userName)
		title = try container.decode(String.self, forKey: .title)
    }
}

struct Streamers: Codable {
	var data: [Streamer]
}
