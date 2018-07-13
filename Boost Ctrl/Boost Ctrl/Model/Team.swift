//
//  Team.swift
//  test
//
//  Created by Zac Johnson on 7/5/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import UIKit

class Teams {
	static let teamArray = [
		Team(id: 1, category: .rlcsNA, name: "Allegiance", player1: "Allushin", player2: "TyNotTyler", player3: "Sea-Bass", standing: "8", win: "0", loss: "0", winPercentage: "63.0", backgroundColor: UIColor(red: 230.0/255, green: 126.0/255, blue: 34.0/255, alpha: 1)),
		Team(id: 2, category: .rlcsNA, name: "Cloud9", player1: "Squishy", player2: "Torment", player3: "Gimmick", standing: "3", win: "0", loss: "0", winPercentage: "57.7", backgroundColor: UIColor(red: 29.0/255, green: 174.0/255, blue: 236.0/255, alpha: 1)),
		Team(id: 3, category: .rlcsNA, name: "Evil Geniuses", player1: "CorruptedG", player2: "Klassux", player3: "Chicago", standing: "4", win: "0", loss: "0", winPercentage: "53.3", backgroundColor: UIColor(red: 64.0/255, green: 115.0/255, blue: 158.0/255, alpha: 1)),
		Team(id: 4, category: .rlcsNA, name: "FlyQuest", player1: "PrimeThunder", player2: "Wonder", player3: "AyyJayy", standing: "7", win: "0", loss: "0", winPercentage: "76.9", backgroundColor: UIColor(red: 59.0/255, green: 117.0/255, blue: 55.0/255, alpha: 1)),
		Team(id: 5, category: .rlcsNA, name: "G2", player1: "Kronovi", player2: "Rizzo", player3: "JKnaps", standing: "1", win: "0", loss: "0", winPercentage: "66.7", backgroundColor: UIColor(red: 169.0/255, green: 169.0/255, blue: 169.0/255, alpha: 1)),
		Team(id: 6, category: .rlcsNA, name: "Ghost", player1: "Lethamyr", player2: "Zanejackey", player3: "Matt", standing: "6", win: "0", loss: "0", winPercentage: "38.5", backgroundColor: UIColor(red: 47.0/255, green: 47.0/255, blue: 47.0/255, alpha: 1)),
		Team(id: 7, category: .rlcsNA, name: "NRG", player1: "Fireburner", player2: "GarrettG", player3: "jstn", standing: "2", win: "0", loss: "0", winPercentage: "75.0", backgroundColor: UIColor(red: 252.0/255, green: 102.0/255, blue: 125.0/255, alpha: 1)),
		Team(id: 8, category: .rlcsNA, name: "Rogue", player1: "Sizz", player2: "Jacob", player3: "TBA", standing: "5", win: "0", loss: "0", winPercentage: "46.4", backgroundColor: UIColor(red: 41.0/255, green: 128.0/255, blue: 185.0/255, alpha: 1)),
		
		
		Team(id: 11, category: .rlcsEU, name: "Complexity", player1: "al0t", player2: "Mognus", player3: "Metsanauris", standing: "2", win: "0", loss: "0", winPercentage: "62.1", backgroundColor: UIColor(red: 240.0/255, green: 86.0/255, blue: 89.0/255, alpha: 1)),
		Team(id: 12, category: .rlcsEU, name: "Dignitas", player1: "ViolentPanda", player2: "Kaydop", player3: "Turbopolsa", standing: "1", win: "0", loss: "0", winPercentage: "64.3", backgroundColor: UIColor(red: 45.0/255, green: 52.0/255, blue: 54/255, alpha: 1)),
		Team(id: 13, category: .rlcsEU, name: "EnVy", player1: "Remkoe", player2: "Deevo", player3: "EyeIgnite", standing: "4", win: "0", loss: "0", winPercentage: "48.4", backgroundColor: UIColor(red: 0/255, green: 15.0/255, blue: 29.0/255, alpha: 1)),
		Team(id: 14, category: .rlcsEU, name: "Flipsid3", player1: "kuxir97", player2: "miztik", player3: "Yukeo", standing: "5", win: "0", loss: "0", winPercentage: "57.1", backgroundColor: UIColor(red: 68.0/255, green: 189.0/255, blue: 50.0/255, alpha: 1)),
		Team(id: 15, category: .rlcsEU, name: "Fnatic", player1: "Snaski", player2: "Maestro", player3: "TBA", standing: "7", win: "0", loss: "0", winPercentage: "28.6", backgroundColor: UIColor(red: 204.0/255, green: 142.0/255, blue: 53.0/255, alpha: 1)),
		Team(id: 16, category: .rlcsEU, name: "PSG", player1: "Ferra", player2: "Chausette45", player3: "Bluey", standing: "6", win: "0", loss: "0", winPercentage: "45.2", backgroundColor: UIColor(red: 47.0/255, green: 53.0/255, blue: 94.0/255, alpha: 1)),
		Team(id: 17, category: .rlcsEU, name: "Servette", player1: "Alex161", player2: "Skyline", player3: "TBA", standing: "8", win: "0", loss: "0", winPercentage: "63.0", backgroundColor: UIColor(red: 196.0/255, green: 69.0/255, blue: 105.0/255, alpha: 1)),
		Team(id: 18, category: .rlcsEU, name: "Vitality", player1: "Paschy90", player2: "Fairy Peak!", player3: "TBA", standing: "3", win: "0", loss: "0", winPercentage: "61.3", backgroundColor: UIColor(red: 246.0/255, green: 175.0/255, blue: 42.0/255, alpha: 1)),
		
		
		Team(id: 21, category: .rlcsOCE, name: "Cheifs", player1: "Jake", player2: "Drippay", player3: "Torsos", standing: "1", win: "0", loss: "0", winPercentage: "80.8", backgroundColor: UIColor(red: 4.0/255, green: 40.0/255, blue: 67.0/255, alpha: 1)),
		Team(id: 22, category: .rlcsOCE, name: "Tainted Minds", player1: "CJCJ", player2: "Kamii", player3: "julz", standing: "2", win: "0", loss: "0", winPercentage: "50.0", backgroundColor: UIColor(red: 102.0/255, green: 156.0/255, blue: 49.0/255, alpha: 1)),
		
		
		Team(id: 31, category: .rlrsNA, name: "CLG", player1: "Dappur", player2: "Timi", player3: "Mijo", standing: "1", win: "0", loss: "0", winPercentage: "37.0", backgroundColor: UIColor(red: 166.0/255, green: 227.0/255, blue: 253.0/255, alpha: 1)),
		Team(id: 32, category: .rlrsNA, name: "SpaceStation", player1: "Memory", player2: "Halcyon", player3: "Vince", standing: "2", win: "0", loss: "0", winPercentage: "60.0", backgroundColor: UIColor(red: 25.0/255, green: 17.0/255, blue: 12.0/255, alpha: 1)),
		
		
		Team(id: 41, category: .rlrsEU, name: "Team Secret", player1: "Tylacto", player2: "FlamE", player3: "Tigreee", standing: "1", win: "0", loss: "0", winPercentage: "66.7", backgroundColor: UIColor.black)
	]
}

enum TeamCategory {
	case rlcsNA
	case rlcsEU
	case rlcsOCE
	case rlrsNA
	case rlrsEU
	
	static func allValues() -> [TeamCategory] {
		return [.rlcsNA, .rlcsEU, .rlcsOCE, .rlrsNA, .rlrsEU]
	}
}

struct Team {
	let id: Int
	let category: TeamCategory
	let name: String
	let player1: String
	let player2: String
	let player3: String
	let standing: String
	let win: String
	let loss: String
	let winPercentage: String
	let backgroundColor: UIColor
}
