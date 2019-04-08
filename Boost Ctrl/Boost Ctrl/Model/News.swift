//
//  News.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/17/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import Foundation

// MARK: - NewsCategory Enum

// Used for red tags on the news feed
enum NewsCategory {
	case News
	case Rumor
	case Article
	case Roster_News
	case Tournament
	case Match_Result
	case Psyonix_Official
	
	static func allValues() -> [NewsCategory] {
		return [.News, .Rumor, .Article, .Roster_News, .Tournament, .Match_Result, .Psyonix_Official]
	}
}

//////////////////////////////////////////////

// MARK: - News item

class News {
	var headline: String = ""
	var detail: String = ""
	var category: NewsCategory = .News
	var link: String = ""
	var siteName: String = ""
	
	func setCategory(category: String) -> NewsCategory {
		switch category.lowercased() {
		case "news":
			return .News
		case "rumor":
			return .Rumor
		case "article":
			return .Article
		case "roster news", "roster", "roster move", "rosternews", "rostermove":
			return .Roster_News
		case "tournament", "lan", "rlcs lan", "promotion", "promotion tournament", "tourney", "rlcs":
			return .Tournament
		case "match result", "match", "matchresult", "result":
			return .Match_Result
		case "psyonix official", "psyonix", "":
			return .Psyonix_Official
		default:
			return .News
		}
	}
}
