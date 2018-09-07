//
//  Standing.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 9/1/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import UIKit

enum StandingCategory {
	case rlcs_NA
	case rlcs_EU
	case rlcs_OCE
	case rlrs_NA
	case rlrs_EU
	
	static func allValues() -> [StandingCategory] {
		return [.rlcs_NA, .rlcs_EU, .rlcs_OCE, .rlrs_NA, .rlrs_EU]
	}
}

struct Standing {
	var id: String = ""
	var category: StandingCategory = .rlcs_NA
	var place: String = ""
	var win: String = ""
	var loss: String = ""
	var wp: String = ""
	
	func setCategory(id: Int) -> StandingCategory {
		
		switch(id) {
			
		case 0...9 :
			return .rlcs_NA
			
		case 10...19 :
			return .rlcs_EU
			
		case 20...29 :
			return .rlcs_OCE
			
		case 30...39 :
			return .rlrs_NA
			
		case 40...49 :
			return .rlrs_EU
			
		default :
			return .rlcs_NA
		}
	}
}
