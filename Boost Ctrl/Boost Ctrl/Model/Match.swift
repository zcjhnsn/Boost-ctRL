//
//  Match.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/17/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import UIKit

// MARK: - Week enum

// For ACTabScrollView tabs on Matches screen
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
		return [.week_1, .week_2, .week_3, .week_4, .week_5, .regionals, .championship, .promotion]
	}
}

//////////////////////////////////////////////

// MARK: - Match struct

struct Match {
	var id: String = ""
	var week: Week = .week_1
	var region: Int = 0
	var teamOneID: String = ""
	var teamTwoID: String = ""
	var oneScore: String = ""
	var twoScore: String = ""
	var teamOne: String = ""
	var teamTwo: String = ""
	var date: String = ""
	var title: String = ""
	var teamOneColor: UIColor = UIColor.blue
	var teamTwoColor: UIColor = UIColor.red
	
	func setWeek(weekID: Int) -> Week {
		switch(weekID) {
		case 1 :
			return .week_1
		case 2 :
			return .week_2
		case 3 :
			return .week_3
		case 4 :
			return .week_4
		case 5 :
			return .week_5
		case 6 :
			return .regionals
		case 7 :
			return .championship
		case 8 :
			return .promotion
		default :
			return .week_1
		}
	}
}
