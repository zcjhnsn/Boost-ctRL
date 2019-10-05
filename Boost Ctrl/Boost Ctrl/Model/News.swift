//
//  News.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/17/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import Foundation

// MARK: - NewsCategory Enum

/// Used for red tags on the news feed
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
	
	/// Headline/cell title
	var headline: String = ""
	
	/// Detail/sub-headline on the cell
	var detail: String = ""
	
	/// News category
	var category: NewsCategory = .News
	
	/// URL for the news item
	var link: String = ""
	
	/// URL domain
	var siteName: String = ""
	
	
	/// ID for the news item (`snapshot.key`)
	var id: String = ""
	
	
	/// Sets the category for the news item
	///
	/// - Parameter category: string description of category
	/// - Returns: NewsCategory enum
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
