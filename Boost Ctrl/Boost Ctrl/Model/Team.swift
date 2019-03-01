//
//  Team.swift
//  test
//
//  Created by Zac Johnson on 7/5/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import UIKit
import Firebase

class Teams {
	 static var teamArray = [
		Team(id: "38", region: 0, category: .rlcs_NA, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.blue),
		Team(id: "38", region: 0, category: .rlcs_NA, name: "", player1: "", player2: "", player3: "", standing:0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.blue),
		Team(id: "38", region: 0, category: .rlcs_NA, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.blue),
		Team(id: "38", region: 0, category: .rlcs_NA, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.blue),
		Team(id: "38", region: 0, category: .rlcs_NA, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.blue),
		Team(id: "38", region: 0, category: .rlcs_NA, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.blue),
		Team(id: "38", region: 0, category: .rlcs_NA, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.blue),
		Team(id: "38", region: 0, category: .rlcs_NA, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.blue),


		Team(id: "38", region: 0, category: .rlcs_EU, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.red),
		Team(id: "38", region: 0, category: .rlcs_EU, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.red),
		Team(id: "38", region: 0, category: .rlcs_EU, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.red),
		Team(id: "38", region: 0, category: .rlcs_EU, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.red),
		Team(id: "38", region: 0, category: .rlcs_EU, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.red),
		Team(id: "38", region: 0, category: .rlcs_EU, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.red),
		Team(id: "38", region: 0, category: .rlcs_EU, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.red),
		Team(id: "38", region: 0, category: .rlcs_EU, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.red),


		Team(id: "38", region: 0, category: .rlcs_OCE, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.green),
		Team(id: "38", region: 0, category: .rlcs_OCE, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.green),
		Team(id: "38", region: 0, category: .rlcs_OCE, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.green),
		Team(id: "38", region: 0, category: .rlcs_OCE, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.green),
		Team(id: "38", region: 0, category: .rlcs_OCE, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.green),
		Team(id: "38", region: 0, category: .rlcs_OCE, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.green),
		Team(id: "38", region: 0, category: .rlcs_OCE, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.green),
		Team(id: "38", region: 0, category: .rlcs_OCE, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.green),

		Team(id: "38", region: 0, category: .rlrs_NA, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.orange),
		Team(id: "38", region: 0, category: .rlrs_NA, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.orange),
		Team(id: "38", region: 0, category: .rlrs_NA, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.orange),
		Team(id: "38", region: 0, category: .rlrs_NA, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.orange),
		Team(id: "38", region: 0, category: .rlrs_NA, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.orange),
		Team(id: "38", region: 0, category: .rlrs_NA, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.orange),
		Team(id: "38", region: 0, category: .rlrs_NA, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.orange),
		Team(id: "38", region: 0, category: .rlrs_NA, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.orange),

		Team(id: "38", region: 0, category: .rlrs_EU, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.black),
		Team(id: "38", region: 0, category: .rlrs_EU, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.black),
		Team(id: "38", region: 0, category: .rlrs_EU, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.black),
		Team(id: "38", region: 0, category: .rlrs_EU, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.black),
		Team(id: "38", region: 0, category: .rlrs_EU, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.black),
		Team(id: "38", region: 0, category: .rlrs_EU, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.black),
		Team(id: "38", region: 0, category: .rlrs_EU, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.black),
		Team(id: "38", region: 0, category: .rlrs_EU, name: "", player1: "", player2: "", player3: "", standing: 0, win: "", loss: "", winPercentage: 0, backgroundColor: UIColor.black)
	]	
}

enum TeamCategory {
	case rlcs_NA
	case rlcs_EU
	case rlcs_OCE
	case rlrs_NA
	case rlrs_EU
	
	static func allValues() -> [TeamCategory] {
		return [.rlcs_NA, .rlcs_EU, .rlcs_OCE, .rlrs_NA, .rlrs_EU]
	}
}

struct Team {
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
	var winPercentage: Int = 0
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
			
		default :
			return .rlcs_NA
		}
	}
}
