//
//  Team.swift
//  test
//
//  Created by Zac Johnson on 7/5/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import UIKit
import Firebase

// MARK: - TeamCategory Enum

// Used for ACTabScrollView tabs
enum TeamCategory {
	case rlcs_NA
	case rlcs_EU
	case rlcs_OCE
	case rlcs_SAM
	case rlrs_NA
	case rlrs_EU
	
	static func allValues() -> [TeamCategory] {
		return [.rlcs_NA, .rlcs_EU, .rlcs_OCE, .rlcs_SAM, .rlrs_NA, .rlrs_EU]
	}
}

//////////////////////////////////////////////

// MARK: - Team Struct

struct Team {
	var abbr: String = ""
	var id: String = ""
	var region: Int = 0
	var category: TeamCategory = .rlcs_NA
	var name: String = ""
	var player1: String = ""
	var player2: String = ""
	var player3: String = ""
	var standing: Int = 0
	var win: String = ""
	var loss: String = ""
	var gameDifferential: Int = 0
	var logo: String? = nil
	
	// For Match Cell
	var backgroundColor: UIColor = UIColor.black
	
	func setCategory(region: Int) -> TeamCategory {
		switch(region) {
		case 0:
			return .rlcs_NA
		case 1:
			return .rlcs_EU
		case 2:
			return .rlcs_OCE
		case 3:
			return .rlrs_NA
		case 4:
			return .rlrs_EU
		case 5:
			return .rlcs_SAM
		default :
			return .rlcs_NA
		}
	}
}
