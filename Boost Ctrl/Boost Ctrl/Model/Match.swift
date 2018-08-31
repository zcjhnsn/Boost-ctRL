//
//  Match.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/17/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import Foundation

class Matches {
	// let matchesArray = array from app delegate method
}

enum Week {
	case week_1
	case week_2
	case week_3
	case week_4
	case week_5
	case week_6
	case promotion
	case regionals
	case championship
	
	static func allValues() -> [Week] {
		return [.week_1, .week_2, .week_3, .week_4, .week_5, .week_6, .promotion, .regionals, .championship]
	}
}

struct Match {
	var week: Week
	var region: String
	var teamOneID: String
	var teamTwoID: String
	var oneScore: String
	var twoScore: String
	
	func setWeek(weekID: String) -> Week {
		switch(weekID) {
			
		case "1" :
			return .week_1
			
		case "2" :
			return .week_2
			
		case "3" :
			return .week_3
			
		case "4" :
			return .week_4
			
		case "5" :
			return .week_5
			
		case "6" :
			return .week_6
			
		case "7" :
			return .promotion
			
		case "8" :
			return .regionals
			
		case "9" :
			return .championship
			
		default :
			return .week_1
		}
	}
	
}
