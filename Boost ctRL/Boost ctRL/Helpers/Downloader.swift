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
			
			let team = RealmTeam()
			
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
            
            
            team.id = String(id)
            team.region = region
            team.name = name
            team.abbreviatedName = abbreviatedName
            team.standing = standing
            team.win = String(win)
            team.loss = String(loss)
            team.gameDifferential = gameDifferential
            team.backgroundColor = backgroundColor
            team.player1 = player1
            team.player2 = player2
            team.player3 = player3
			
			team.writeToRealm()
			moveOn = false
		}
		
		return moveOn
	}
	
	//////////////////////////////////////////////
	
	// MARK: - Child Changed Listener for Teams
		
    
    /// Listener for when team data changes. If any team information is missing, the team is not saved to realm.
	func updateTeamsAndStandings() {
		let standingsDB = Database.database().reference().child("standings")
		
		standingsDB.observe(.childChanged) { (snapshot) in

			print("Updating teams and standings... ⏳")
			let snapshotValue = snapshot.value as! Dictionary<String, Any>
			
			let team = RealmTeam()
            
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
                                 
			
            team.id = String(id)
            team.region = region
            team.name = name
            team.abbreviatedName = abbreviatedName
            team.standing = standing
            team.win = String(win)
            team.loss = String(loss)
            team.gameDifferential = gameDifferential
            team.backgroundColor = backgroundColor
            team.player1 = player1
            team.player2 = player2
            team.player3 = player3
			
			team.writeToRealm()
		}

		print("Update teams and standings: Complete ✅")
	}

	//////////////////////////////////////////////
	
	// MARK: - Load matches
    
    /// Loads match data for RLCS + RLRS
    ///
    /// - Returns: Bool
	func loadMatches() -> Bool {
		let moveOn = true
		
		loadRLCS()
		reloadRLCSMatches()
		
		loadRLRS()
		reloadRLRSMatches()
		
		return moveOn
	}
	
	//////////////////////////////////////////////
	
	// MARK: - Initial Firebase calls for Matches
	
    
    /// Downloads RLCS match data. If any match information is missing, the match is not saved to realm.
    func loadRLCS() {
		let rlcsDB = Database.database().reference().child("matches").child("rlcs")
		
		print("Loading RLCS Matches ⏳")

		rlcsDB.observe(.childAdded) { (snapshot) in
			let snapshotValue = snapshot.value as! Dictionary<String, Any>
			
			let match = RealmMatchRLCS()
            
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
            
            match.id = id
            match.teamOneID = String(teamOneID)
			match.teamTwoID = String(teamTwoID)
			match.oneScore = String(oneScore)
			match.twoScore = String(twoScore)
			match.region = region
			match.week = week
			match.date = date
			match.title = title
			
			match.writeToRLCSRealm()
		}
	}
	
    
    /// Downloads RLRS match data. If any match information is missing, the match is not saved to realm.
	func loadRLRS() {
		let rlrsDB = Database.database().reference().child("matches").child("rlrs")
		
		rlrsDB.observe(.childAdded) { (snapshot) in
			let snapshotValue = snapshot.value as! Dictionary<String, Any>
			
			let match = RealmMatchRLRS()
			
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
            
            match.id = id
            match.teamOneID = String(teamOneID)
            match.teamTwoID = String(teamTwoID)
            match.oneScore = String(oneScore)
            match.twoScore = String(twoScore)
            match.region = region
            match.week = week
            match.date = date
            match.title = title
			
			match.writeToRLRSRealm()
		}
	}
	
	//////////////////////////////////////////////
	
	// MARK: - Matches Child Changed Listeners
	
    /// Listener for RLCS matches. If any match information is missing, the match is not updated.
	func reloadRLCSMatches() {
		let rlcsDB = Database.database().reference().child("matches").child("rlcs")
		
		rlcsDB.observe(.childChanged) { (snapshot) in
			let snapshotValue = snapshot.value as! Dictionary<String, Any>
			
			let match = RealmMatchRLCS()
			
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
            
            match.id = id
            match.teamOneID = String(teamOneID)
            match.teamTwoID = String(teamTwoID)
            match.oneScore = String(oneScore)
            match.twoScore = String(twoScore)
            match.region = region
            match.week = week
            match.date = date
            match.title = title
            
            match.writeToRLCSRealm()
		}
	}
	
    /// Listener for RLRS matches. If any match information is missing, the match is not updated.
	func reloadRLRSMatches() {
		let rlrsDB = Database.database().reference().child("matches").child("rlrs")
		
		rlrsDB.observe(.childChanged) { (snapshot) in
			let snapshotValue = snapshot.value as! Dictionary<String, Any>
			
			let match = RealmMatchRLRS()
			
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
            
            match.id = id
            match.teamOneID = String(teamOneID)
            match.teamTwoID = String(teamTwoID)
            match.oneScore = String(oneScore)
            match.twoScore = String(twoScore)
            match.region = region
            match.week = week
            match.date = date
            match.title = title
			
			match.writeToRLRSRealm()
		}
	}

    
    /// Gets RLCS matches one time
    ///
    /// - Parameter completion: refresh TableView data
    static func fetchRLCSOnce(completion: @escaping () -> Void) {
        let rlcsDB = Database.database().reference().child("matches").child("rlcs")

        rlcsDB.observeSingleEvent(of: .childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, Any>

            let match = RealmMatchRLCS()

            guard let id = snapshotValue["id"] as? String,
                let team1Id = snapshotValue["1id"] as? Int,
                let team2id = snapshotValue["2id"] as? Int,
                let team1Score = snapshotValue["1s"] as? Int,
                let team2Score = snapshotValue["2s"] as? Int,
                let region = snapshotValue["r"] as? Int,
                let week = snapshotValue["w"] as? Int,
                let date = snapshotValue["d"] as? String,
                let title = snapshotValue["t"] as? String else {
                    completion()
                    return
            }

            match.id = id

            match.teamOneID = String(team1Id)
            match.teamTwoID = String(team2id)

            match.oneScore = String(team1Score)
            match.twoScore = String(team2Score)

            match.region = region
            match.week = week

            match.date = date
            match.title = title

            match.writeToRLCSRealm()
            completion()
        }
    }

    /// Gets RLRS matches one time
    ///
    /// - Parameter completion: refresh TableView data
    static func fetchRLRSOnce(completion: @escaping () -> Void) {
        let rlcsDB = Database.database().reference().child("matches").child("rlrs")

        rlcsDB.observeSingleEvent(of: .childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, Any>

            let match = RealmMatchRLRS()

            guard let id = snapshotValue["id"] as? String,
                let team1Id = snapshotValue["1id"] as? Int,
                let team2id = snapshotValue["2id"] as? Int,
                let team1Score = snapshotValue["1s"] as? Int,
                let team2Score = snapshotValue["2s"] as? Int,
                let region = snapshotValue["r"] as? Int,
                let week = snapshotValue["w"] as? Int,
                let date = snapshotValue["d"] as? String,
                let title = snapshotValue["t"] as? String else {
                    completion()
                    return
            }

            match.id = id

            match.teamOneID = String(team1Id)
            match.teamTwoID = String(team2id)

            match.oneScore = String(team1Score)
            match.twoScore = String(team2Score)

            match.region = region
            match.week = week

            match.date = date
            match.title = title

            match.writeToRLRSRealm()
            completion()
        }
    }
}
