//
//  Enumerations.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 8/30/19.
//  Copyright © 2019 Zac Johnson. All rights reserved.
//

import UIKit


/// Color scheme for this app
enum ctRLTheme {
	/// Darkest blue, almost navy
	static let midnightBlue = UIColor(hex: "283149")!
	
	/// Lighter dark blue, grayish blue
	static let darkBlue = UIColor(hex: "404b69")!
	
	/// Pink accent color
	static let hotPink = UIColor(hex: "f73859")!
	
	/// Text color
	static let cloudWhite = UIColor(hex: "dbedf3")!
}


/// Parameter names for Analytics events
enum EventParameter {
	// For match results
	static let matchID = "match_id"
	static let teamOneID = "team_one_id"
	static let teamTwoID = "team_two_id"
	
	// For team pages
	static let teamID = "team_id"
	static let teamName = "team_name"
	
	// For news
	static let newsItemID = "news_item_id"
	static let newsItemTitle = "news_item_title"
	static let newsSite = "news_site"
	static let newsCategory = "news_category"
}

enum EventType {
	static let results = "results"
	static let news = "news"
	static let newsNotification = "news_notification"
	static let resultNotification = "result_notification"
	static let team = "team"
}

enum AvenirNext: String {
	case regular = "AvenirNext-Regular"
	case ultraLight = "AvenirNext-UltraLight"
	case demibold = "AvenirNext-Demibold"
	case medium = "AvenirNext-Medium"
	
	func size(_ size: CGFloat) -> UIFont? {
		return UIFont(name: self.rawValue, size: size)
	}
}

enum Site {
	case octane
	case rocketeers
	case twitch
}

enum Constants {
	static let CloudKitID = "iCloud.com.zacjohnson.Boost-ctRL"
	static let TwitchClientID = "twitchClientID"
	static let TwitchClientSecret = "twitchClientSecret"
	static let TwitchIDForRL = "30921"
}
