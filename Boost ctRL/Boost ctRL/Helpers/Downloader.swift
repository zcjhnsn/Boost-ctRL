//
//  Downloader.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/11/19.
//  Copyright © 2019 Zac Johnson. All rights reserved.
//

import Foundation
import Firebase
import RealmSwift

// MARK: - Networking Class

class Downloader {
	
	// MARK: - Initial Firebase call for Teams
	
	func loadTeamsAndStandings() -> Bool {
		
		var moveOn = true
		
		print("Fetching Teams... ⏳")
		
		let standingsDB = Database.database().reference().child("standings")
		
		standingsDB.observe(.childAdded) {
			(snapshot) in
			let snapshotValue = snapshot.value as! Dictionary<String, Any>
			
			var team = RealmTeam()
			
			team.id = String(snapshotValue["id"]! as! Int)
			team.region = snapshotValue["r"] as! Int
			team.name = snapshotValue["n"]! as! String
			team.abbreviatedName = snapshotValue["a"]! as! String
			team.standing = snapshotValue["s"]! as! Int
			team.win = String(snapshotValue["w"]! as! Int)
			team.loss = String(snapshotValue["l"]! as! Int)
			team.gameDifferential = snapshotValue["gd"]! as! Int
			team.backgroundColor = snapshotValue["c"]! as! String
			team.player1 = snapshotValue["p1"]! as! String
			team.player2 = snapshotValue["p2"]! as! String
			team.player3 = snapshotValue["p3"]! as! String
			
			team.writeToRealm()
			moveOn = false
		}
		
		return moveOn
	}
	
	//////////////////////////////////////////////
	
	// MARK: - Child Changed Listener for Teams
		
	func updateTeamsAndStandings() {
		let standingsDB = Database.database().reference().child("standings")
		
		standingsDB.observe(.childChanged) { (snapshot) in

			print("Updating teams and standings... ⏳")
			let snapshotValue = snapshot.value as! Dictionary<String, Any>
			
			var team = RealmTeam()
			
			team.id = String(snapshotValue["id"]! as! Int)
			team.region = snapshotValue["r"] as! Int
			team.name = snapshotValue["n"]! as! String
			team.abbreviatedName = snapshotValue["a"]! as! String
			team.standing = snapshotValue["s"]! as! Int
			team.win = String(snapshotValue["w"]! as! Int)
			team.loss = String(snapshotValue["l"]! as! Int)
			team.gameDifferential = snapshotValue["gd"]! as! Int
			team.backgroundColor = snapshotValue["c"]! as! String
			team.player1 = snapshotValue["p1"]! as! String
			team.player2 = snapshotValue["p2"]! as! String
			team.player3 = snapshotValue["p3"]! as! String
			
			team.writeToRealm()
		}

		print("Update teams and standings: Complete ✅")
	}

	//////////////////////////////////////////////
	
	// MARK: - Load matches
	func loadMatches() -> Bool {
		var moveOn = true
		
		loadRLCS()
		reloadRLCSMatches()
		
		loadRLRS()
		reloadRLRSMatches()
		
		return moveOn
	}
	
	//////////////////////////////////////////////
	
	// MARK: - Initial Firebase calls for Matches
	
	func loadRLCS() {
		let rlcsDB = Database.database().reference().child("matches").child("rlcs")
		
		print("Loading RLCS Matches ⏳")
		
		rlcsDB.observe(.childAdded) { (snapshot) in
			let snapshotValue = snapshot.value as! Dictionary<String, Any>
			
			var match = RealmMatchRLCS()
			
			match.id = snapshotValue["id"]! as! String
			
			match.teamOneID = String(snapshotValue["1id"]! as! Int)
			match.teamTwoID = String(snapshotValue["2id"]! as! Int)
			
			match.oneScore = String(snapshotValue["1s"]! as! Int)
			match.twoScore = String(snapshotValue["2s"]! as! Int)
			
			match.region = snapshotValue["r"]! as! Int
			
			match.week = snapshotValue["w"]! as! Int
			
			match.date = snapshotValue["d"] as! String
			match.title = snapshotValue["t"] as! String
			
			match.writeToRLCSRealm()
		}
	}
	
	func loadRLRS() {
		let rlrsDB = Database.database().reference().child("matches").child("rlrs")
		
		rlrsDB.observe(.childAdded) { (snapshot) in
			let snapshotValue = snapshot.value as! Dictionary<String, Any>
			
			var match = RealmMatchRLRS()
			
			match.id = snapshotValue["id"]! as! String
			
			match.teamOneID = String(snapshotValue["1id"]! as! Int)
			match.teamTwoID = String(snapshotValue["2id"]! as! Int)
			
			match.oneScore = String(snapshotValue["1s"]! as! Int)
			match.twoScore = String(snapshotValue["2s"]! as! Int)
			
			match.region = snapshotValue["r"]! as! Int
			match.week = snapshotValue["w"]! as! Int
			
			match.date = snapshotValue["d"] as! String
			match.title = snapshotValue["t"] as! String
			
			match.writeToRLRSRealm()
		}
	}
	
	//////////////////////////////////////////////
	
	// MARK: - Matches Child Changed Listeners
	
	func reloadRLCSMatches() {
		let rlcsDB = Database.database().reference().child("matches").child("rlcs")
		
		rlcsDB.observe(.childChanged) { (snapshot) in
			let snapshotValue = snapshot.value as! Dictionary<String, Any>
			
			var match = RealmMatchRLCS()
			
			match.id = snapshotValue["id"]! as! String
			
			match.teamOneID = String(snapshotValue["1id"]! as! Int)
			match.teamTwoID = String(snapshotValue["2id"]! as! Int)
			
			match.oneScore = String(snapshotValue["1s"]! as! Int)
			match.twoScore = String(snapshotValue["2s"]! as! Int)
			
			match.region = snapshotValue["r"]! as! Int
			match.week = snapshotValue["w"]! as! Int
			
			match.date = snapshotValue["d"] as! String
			match.title = snapshotValue["t"] as! String
			
			match.writeToRLCSRealm()
		}
	}
	
	func reloadRLRSMatches() {
		let rlrsDB = Database.database().reference().child("matches").child("rlrs")
		
		rlrsDB.observe(.childChanged) { (snapshot) in
			let snapshotValue = snapshot.value as! Dictionary<String, Any>
			
			var match = RealmMatchRLRS()
			
			match.id = snapshotValue["id"]! as! String
			
			match.teamOneID = String(snapshotValue["1id"]! as! Int)
			match.teamTwoID = String(snapshotValue["2id"]! as! Int)
			
			match.oneScore = String(snapshotValue["1s"]! as! Int)
			match.twoScore = String(snapshotValue["2s"]! as! Int)
			
			match.region = snapshotValue["r"]! as! Int
			match.week = snapshotValue["w"]! as! Int
			
			match.date = snapshotValue["d"] as! String
			match.title = snapshotValue["t"] as! String
			
			match.writeToRLRSRealm()
		}
	}
	
}
