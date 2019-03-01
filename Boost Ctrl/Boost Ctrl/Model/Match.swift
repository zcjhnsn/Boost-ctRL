//
//  Match.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/17/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import UIKit

struct Matches {
	// let matchesArray = array from app delegate method
	static var rlcsArray = [
		[
			Match(week: .week_1, region: 0, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .week_1, region: 0, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			 Match(week: .week_2, region: 0, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			 Match(week: .week_3, region: 0, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			 Match(week: .week_4, region: 0, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			 Match(week: .week_5, region: 0, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			 Match(week: .week_6, region: 0, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			 Match(week: .regionals, region: 0, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			 Match(week: .championship, region: 0, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			 Match(week: .promotion, region: 0, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
		 ],
		[
			Match(week: .week_1, region: 1, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .week_2, region: 1, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .week_3, region: 1, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .week_4, region: 1, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .week_5, region: 1, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .week_6, region: 1, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .regionals, region: 1, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .championship, region: 1, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .promotion, region: 1, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange)
		 ],
		[
			Match(week: .week_1, region: 2, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .week_2, region: 2, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .week_3, region: 2, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .week_4, region: 2, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .week_5, region: 2, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .week_6, region: 2, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .regionals, region: 2, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .championship, region: 2, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .promotion, region: 2, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange)
		]
	]
	
	static var rlrsArray = [
		[
			Match(week: .week_1, region: 3, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .week_2, region: 3, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .week_3, region: 3, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .week_4, region: 3, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .week_5, region: 3, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .week_6, region: 3, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .regionals, region: 3, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .championship, region: 3, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .promotion, region: 3, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange)
		],
		[
			Match(week: .week_1, region: 4, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .week_2, region: 4, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .week_3, region: 4, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .week_4, region: 4, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .week_5, region: 4, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .week_6, region: 4, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .regionals, region: 4, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .championship, region: 4, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange),
			Match(week: .promotion, region: 4, teamOneID: "", teamTwoID: "", oneScore: "", twoScore: "", teamOne: "", teamTwo: "", teamOneColor: UIColor.blue, teamTwoColor: UIColor.orange)
		]
	]
	
	func getRLCS() -> [[Match]] {
		return Matches.rlcsArray
	}
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
		return [.week_1, .week_2, .week_3, .week_4, .week_5, .week_6, .regionals, .championship, .promotion]
	}
}

struct Match {
	var week: Week = .week_1
	var region: Int = 0
	var teamOneID: String = ""
	var teamTwoID: String = ""
	var oneScore: String = ""
	var twoScore: String = ""
	var teamOne: String = ""
	var teamTwo: String = ""
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
			return .week_6
			
		case 7 :
			return .regionals
			
		case 8 :
			return .championship
			
		case 9 :
			return .promotion
			
		default :
			return .week_1
		}
	}
	
}
