//
//  TwitchTokenResponse.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 5/20/20.
//  Copyright © 2020 Zac Johnson. All rights reserved.
//

import Foundation

struct TwitchTokenResponse: Codable {
	/// User access token
	let accessToken: String
	/// Number of seconds until the token expires
    let expiresIn: Int
	
	let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
		case expiresIn = "expires_in"
		case tokenType = "token_type"
    }
	
	init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try container.decode(String.self, forKey: .accessToken)
        expiresIn = try container.decode(Int.self, forKey: .expiresIn)
        tokenType = try container.decode(String.self, forKey: .tokenType)
    }
}
