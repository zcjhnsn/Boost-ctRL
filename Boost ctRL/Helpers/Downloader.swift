//
//  Downloader.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/11/19.
//  Copyright © 2019 Zac Johnson. All rights reserved.
//

import Foundation
import Firebase

// MARK: - Networking Class

class Downloader {
	
	// MARK: - Initial Firebase call for Teams
	
    
    /// Initial download of teams from Firebase. If any team information is missing, the team is not saved to realm.
    ///
    /// - Returns: Bool for completion
	func loadTeamsAndStandings() -> Bool {
		
		var moveOn = true
		
		print("Fetching Teams... ⏳")
		
        let standingsDB = Database.database().reference().child("standings")
		
		standingsDB.observe(.childAdded) {
			(snapshot) in
			let snapshotValue = snapshot.value as! Dictionary<String, Any>
			
			
            guard let id = snapshotValue["id"] as? Int,
                let region = snapshotValue["r"] as? Int,
                let name = snapshotValue["n"] as? String,
                let abbreviatedName = snapshotValue["a"] as? String,
                let standing = snapshotValue["s"] as? Int,
                let win = snapshotValue["w"] as? Int,
                let loss = snapshotValue["l"] as? Int,
                let gameDifferential = snapshotValue["gd"] as? Int,
                let backgroundColor = snapshotValue["c"] as? String,
                let player1 = snapshotValue["p1"] as? String,
                let player2 = snapshotValue["p2"] as? String,
                let player3 = snapshotValue["p3"] as? String else {
                    return
            }
        
			moveOn = false
		}
		
		return moveOn
	}
	
	
	// MARK: - Child Changed Listener for Teams
		
    
    /// Listener for when team data changes. If any team information is missing, the team is not saved to realm.
	func updateTeamsAndStandings() {
		let standingsDB = Database.database().reference().child("standings")
		
		standingsDB.observe(.childChanged) { (snapshot) in

			print("Updating teams and standings... ⏳")
			let snapshotValue = snapshot.value as! Dictionary<String, Any>
			
            
            guard let id = snapshotValue["id"] as? Int,
                let region = snapshotValue["r"] as? Int,
                let name = snapshotValue["n"] as? String,
                let abbreviatedName = snapshotValue["a"] as? String,
                let standing = snapshotValue["s"] as? Int,
                let win = snapshotValue["w"] as? Int,
                let loss = snapshotValue["l"] as? Int,
                let gameDifferential = snapshotValue["gd"] as? Int,
                let backgroundColor = snapshotValue["c"] as? String,
                let player1 = snapshotValue["p1"] as? String,
                let player2 = snapshotValue["p2"] as? String,
                let player3 = snapshotValue["p3"] as? String else {
                    return
            }
                                
		}

		print("Update teams and standings: Complete ✅")
	}

	
	// MARK: - Load matches
    
    /// Loads match data for RLCS + RLRS
    ///
    /// - Returns: Bool
	func loadMatches() -> Bool {
		let moveOn = true
		
		loadRLCS()
		loadRLRS()
		
		return moveOn
	}
	
	
	// MARK: - Initial Firebase calls for Matches
	
    
    /// Downloads RLCS match data. If any match information is missing, the match is not saved to realm.
    func loadRLCS() {
		let rlcsDB = Database.database().reference().child("matches").child("rlcs9")
		
		print("Loading RLCS Matches ⏳")

		rlcsDB.observe(.childAdded) { (snapshot) in
			let snapshotValue = snapshot.value as! Dictionary<String, Any>
			
            
            // If any of these don't exist, don't write to realm because it's a pain to fix
            guard let id = snapshotValue["id"] as? String,
                let teamOneID = snapshotValue["1id"] as? Int,
                let teamTwoID = snapshotValue["2id"] as? Int,
                let oneScore = snapshotValue["1s"] as? Int,
                let twoScore = snapshotValue["2s"] as? Int,
                let region = snapshotValue["r"] as? Int,
                let week = snapshotValue["w"] as? Int,
                let date = snapshotValue["d"] as? String,
                let title = snapshotValue["t"] as? String else { return }
		}
	}
	
    
    /// Downloads RLRS match data. If any match information is missing, the match is not saved to realm.
	func loadRLRS() {
		let rlrsDB = Database.database().reference().child("matches").child("rlrs9")
		
		rlrsDB.observe(.childAdded) { (snapshot) in
			let snapshotValue = snapshot.value as! Dictionary<String, Any>
        
			
            // If any of these don't exist, don't write to realm because it's a pain to fix
            guard let id = snapshotValue["id"] as? String,
                let teamOneID = snapshotValue["1id"] as? Int,
                let teamTwoID = snapshotValue["2id"] as? Int,
                let oneScore = snapshotValue["1s"] as? Int,
                let twoScore = snapshotValue["2s"] as? Int,
                let region = snapshotValue["r"] as? Int,
                let week = snapshotValue["w"] as? Int,
                let date = snapshotValue["d"] as? String,
                let title = snapshotValue["t"] as? String else { return }
            
		}
	}

}
