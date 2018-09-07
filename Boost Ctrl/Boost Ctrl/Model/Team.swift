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
		Team(id: 1, category: .rlcs_NA, name: "Allegiance", player1: "Allushin", player2: "TyNotTyler", player3: "Sea-Bass", standing: "8", win: "0", loss: "0", winPercentage: "63.0", backgroundColor: UIColor(red: 230.0/255, green: 126.0/255, blue: 34.0/255, alpha: 1)),
		Team(id: 2, category: .rlcs_NA, name: "Cloud9", player1: "Squishy", player2: "Torment", player3: "Gimmick", standing: "3", win: "0", loss: "0", winPercentage: "57.7", backgroundColor: UIColor(red: 29.0/255, green: 174.0/255, blue: 236.0/255, alpha: 1)),
		Team(id: 3, category: .rlcs_NA, name: "Evil Geniuses", player1: "CorruptedG", player2: "Klassux", player3: "Chicago", standing: "4", win: "0", loss: "0", winPercentage: "53.3", backgroundColor: UIColor(red: 64.0/255, green: 115.0/255, blue: 158.0/255, alpha: 1)),
		Team(id: 4, category: .rlcs_NA, name: "FlyQuest", player1: "PrimeThunder", player2: "Wonder", player3: "AyyJayy", standing: "7", win: "0", loss: "0", winPercentage: "76.9", backgroundColor: UIColor(red: 59.0/255, green: 117.0/255, blue: 55.0/255, alpha: 1)),
		Team(id: 5, category: .rlcs_NA, name: "G2", player1: "Kronovi", player2: "Rizzo", player3: "JKnaps", standing: "1", win: "0", loss: "0", winPercentage: "66.7", backgroundColor: UIColor(red: 169.0/255, green: 169.0/255, blue: 169.0/255, alpha: 1)),
		Team(id: 6, category: .rlcs_NA, name: "Ghost", player1: "Lethamyr", player2: "Zanejackey", player3: "Memory", standing: "6", win: "0", loss: "0", winPercentage: "38.5", backgroundColor: UIColor(red: 47.0/255, green: 47.0/255, blue: 47.0/255, alpha: 1)),
		Team(id: 7, category: .rlcs_NA, name: "NRG", player1: "Fireburner", player2: "GarrettG", player3: "jstn", standing: "2", win: "0", loss: "0", winPercentage: "75.0", backgroundColor: UIColor(red: 252.0/255, green: 102.0/255, blue: 125.0/255, alpha: 1)),
		Team(id: 8, category: .rlcs_NA, name: "Rogue", player1: "Sizz", player2: "Jacob", player3: "Joro", standing: "5", win: "0", loss: "0", winPercentage: "46.4", backgroundColor: UIColor(red: 41.0/255, green: 128.0/255, blue: 185.0/255, alpha: 1)),
		
		
		Team(id: 11, category: .rlcs_EU, name: "Complexity", player1: "al0t", player2: "Mognus", player3: "gReazymeister", standing: "2", win: "0", loss: "0", winPercentage: "62.1", backgroundColor: UIColor(red: 240.0/255, green: 86.0/255, blue: 89.0/255, alpha: 1)),
		Team(id: 12, category: .rlcs_EU, name: "Dignitas", player1: "ViolentPanda", player2: "Kaydop", player3: "Turbopolsa", standing: "1", win: "0", loss: "0", winPercentage: "64.3", backgroundColor: UIColor(red: 45.0/255, green: 52.0/255, blue: 54/255, alpha: 1)),
		Team(id: 13, category: .rlcs_EU, name: "We Dem Girlz", player1: "Remkoe", player2: "EyeIgnite", player3: "Metsanauris", standing: "4", win: "0", loss: "0", winPercentage: "48.4", backgroundColor: UIColor(red: 0/255, green: 15.0/255, blue: 29.0/255, alpha: 1)),
		Team(id: 14, category: .rlcs_EU, name: "Flipsid3", player1: "kuxir97", player2: "miztik", player3: "Yukeo", standing: "5", win: "0", loss: "0", winPercentage: "57.1", backgroundColor: UIColor(red: 68.0/255, green: 189.0/255, blue: 50.0/255, alpha: 1)),
		Team(id: 15, category: .rlcs_EU, name: "Fnatic", player1: "Snaski", player2: "Maestro", player3: "MummiSnow", standing: "7", win: "0", loss: "0", winPercentage: "28.6", backgroundColor: UIColor(red: 204.0/255, green: 142.0/255, blue: 53.0/255, alpha: 1)),
		Team(id: 16, category: .rlcs_EU, name: "PSG", player1: "Ferra", player2: "Chausette45", player3: "Fruity", standing: "6", win: "0", loss: "0", winPercentage: "45.2", backgroundColor: UIColor(red: 47.0/255, green: 53.0/255, blue: 94.0/255, alpha: 1)),
		Team(id: 17, category: .rlcs_EU, name: "Mousesports", player1: "Alex161", player2: "Skyline", player3: "Tigreee", standing: "8", win: "0", loss: "0", winPercentage: "63.0", backgroundColor: UIColor(red: 179.0/255, green: 23.0/255, blue: 59.0/255, alpha: 1)),
		Team(id: 18, category: .rlcs_EU, name: "Vitality", player1: "Paschy90", player2: "Fairy Peak!", player3: "ScrubKilla", standing: "3", win: "0", loss: "0", winPercentage: "61.3", backgroundColor: UIColor(red: 246.0/255, green: 175.0/255, blue: 42.0/255, alpha: 1)),
		
		
		Team(id: 21, category: .rlcs_OCE, name: "Cheifs", player1: "Kamii", player2: "Drippay", player3: "Torsos", standing: "1", win: "0", loss: "0", winPercentage: "80.8", backgroundColor: UIColor(red: 4.0/255, green: 40.0/255, blue: 67.0/255, alpha: 1)),
		Team(id: 22, category: .rlcs_OCE, name: "Tainted Minds", player1: "CJCJ", player2: "shadey", player3: "Express", standing: "2", win: "0", loss: "0", winPercentage: "50.0", backgroundColor: UIColor(red: 102.0/255, green: 156.0/255, blue: 49.0/255, alpha: 1)),
		Team(id: 23, category: .rlcs_OCE, name: "Ground Zero", player1: "CJM", player2: "Lim", player3: "Walcott", standing: "3", win: "0", loss: "0", winPercentage: "0.0", backgroundColor: UIColor(red: 56.0/255, green: 63.0/255, blue: 77.0/255, alpha: 1)),
		Team(id: 24, category: .rlcs_OCE, name: "ORDER", player1: "Dumbo", player2: "Julz", player3: "ZeN", standing: "4", win: "0", loss: "0", winPercentage: "0.0", backgroundColor: UIColor(red: 252.0/255, green: 33.0/255, blue: 79.0/255, alpha: 1)),
		Team(id: 25, category: .rlcs_OCE, name: "Legacy", player1: "cyrix", player2: "Daze", player3: "Siki", standing: "5", win: "0", loss: "0", winPercentage: "0.0", backgroundColor: UIColor(red: 169.0/255, green: 205.0/255, blue: 79.0/255, alpha: 1)),
		Team(id: 26, category: .rlcs_OCE, name: "Justice", player1: "SSteve", player2: "Whiss", player3: "Yeatzy", standing: "6", win: "0", loss: "0", winPercentage: "0.0", backgroundColor: UIColor(red: 33.0/255, green: 137.0/255, blue: 138.0/255, alpha: 1)),
		Team(id: 27, category: .rlcs_OCE, name: "Chimpwits", player1: "Decka", player2: "Requiem", player3: "Delusion", standing: "7", win: "0", loss: "0", winPercentage: "0.0", backgroundColor: UIColor(red: 64.0/255, green: 76.0/255, blue: 104.0/255, alpha: 1)),
		Team(id: 28, category: .rlcs_OCE, name: "Avant", player1: "Vive", player2: "Bango", player3: "SnarfSnarf", standing: "8", win: "0", loss: "0", winPercentage: "0.0", backgroundColor: UIColor(red: 3.0/255, green: 65.0/255, blue: 140.0/255, alpha: 1)),
		
		Team(id: 31, category: .rlrs_NA, name: "Applesauce", player1: "Hato", player2: "Zolhay", player3: "EPICJohnny", standing: "1", win: "0", loss: "0", winPercentage: "37.0", backgroundColor: UIColor(red: 166.0/255, green: 227.0/255, blue: 253.0/255, alpha: 1)),
		Team(id: 32, category: .rlrs_NA, name: "Magicians", player1: "Rapid", player2: "Halcyon", player3: "Vince", standing: "2", win: "0", loss: "0", winPercentage: "60.0", backgroundColor: UIColor(red: 25.0/255, green: 17.0/255, blue: 12.0/255, alpha: 1)),
		Team(id: 33, category: .rlrs_NA, name: "Manhattan", player1: "ayjacks", player2: "Tmon", player3: "Malakiss", standing: "3", win: "0", loss: "0", winPercentage: "0.0", backgroundColor: UIColor(red: 64.0/255, green: 76.0/255, blue: 104.0/255, alpha: 1)),
		Team(id: 34, category: .rlrs_NA, name: "Splyce", player1: "Karma", player2: "JWismont", player3: "DudeWithTheNose", standing: "4", win: "0", loss: "0", winPercentage: "0.0", backgroundColor: UIColor(red: 151.0/255, green: 119.0/255, blue: 0, alpha: 1)),
		Team(id: 35, category: .rlrs_NA, name: "Bread", player1: "Satthew", player2: "Sypical", player3: "AxB", standing: "5", win: "0", loss: "0", winPercentage: "0.0", backgroundColor: UIColor(red: 64.0/255, green: 76.0/255, blue: 104.0/255, alpha: 1)),
		Team(id: 36, category: .rlrs_NA, name: "The Hosses", player1: "Chrome", player2: "Timi", player3: "Insolences", standing: "6", win: "0", loss: "0", winPercentage: "0.0", backgroundColor: UIColor(red: 64.0/255, green: 76.0/255, blue: 104.0/255, alpha: 1)),
		Team(id: 37, category: .rlrs_NA, name: "Compadres", player1: "Moses", player2: "Aeon", player3: "Astroh", standing: "7", win: "0", loss: "0", winPercentage: "0.0", backgroundColor: UIColor(red: 64.0/255, green: 76.0/255, blue: 104.0/255, alpha: 1)),
		Team(id: 38, category: .rlrs_NA, name: "The Peeps", player1: "Arsenal", player2: "Gyro", player3: "Pirates", standing: "8", win: "0", loss: "0", winPercentage: "0.0", backgroundColor: UIColor(red: 64.0/255, green: 76.0/255, blue: 104.0/255, alpha: 1)),
		
		
		Team(id: 41, category: .rlrs_EU, name: "Team Secret", player1: "Tylacto", player2: "FlamE", player3: "Freakii", standing: "1", win: "0", loss: "0", winPercentage: "66.7", backgroundColor: UIColor.black),
		Team(id: 42, category: .rlrs_EU, name: "exceL", player1: "Nielskoek", player2: "pwndx", player3: "Markydooda", standing: "5", win: "0", loss: "0", winPercentage: "0.0", backgroundColor: UIColor(red: 255.0/255, green: 163.0/255, blue: 6.0/255, alpha: 1)),
		Team(id: 43, category: .rlrs_EU, name: "Triple Trouble", player1: "Tadpole", player2: "Ronaky", player3: "Speed", standing: "3", win: "0", loss: "0", winPercentage: "0.0", backgroundColor: UIColor(red: 169.0/255, green: 169.0/255, blue: 169.0/255, alpha: 1)),
		Team(id: 44, category: .rlrs_EU, name: "Nordavind", player1: "Al Dente", player2: "Data", player3: "Godsmilla", standing: "4", win: "0", loss: "0", winPercentage: "0.0", backgroundColor: UIColor(red: 0/255, green: 15.0/255, blue: 29.0/255, alpha: 1)),
		Team(id: 45, category: .rlrs_EU, name: "Savage!", player1: "Bluey", player2: "Deevo", player3: "Alpha54", standing: "5", win: "0", loss: "0", winPercentage: "0.0", backgroundColor: UIColor(red: 64.0/255, green: 76.0/255, blue: 104.0/255, alpha: 1)),
		Team(id: 46, category: .rlrs_EU, name: "Method", player1: "Borito B", player2: "Kassio", player3: "Rix Ronday", standing: "6", win: "0", loss: "0", winPercentage: "0.0", backgroundColor: UIColor.black),
		Team(id: 47, category: .rlrs_EU, name: "The Clappers", player1: "Calix", player2: "Oscillon", player3: "Petrick", standing: "7", win: "0", loss: "0", winPercentage: "0.0", backgroundColor: UIColor(red: 64.0/255, green: 76.0/255, blue: 104.0/255, alpha: 1)),
		Team(id: 48, category: .rlrs_EU, name: "The Bricks", player1: "Friis", player2: "Didris", player3: "Shakahron", standing: "8", win: "0", loss: "0", winPercentage: "0.0", backgroundColor: UIColor(red: 64.0/255, green: 76.0/255, blue: 104.0/255, alpha: 1))
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
