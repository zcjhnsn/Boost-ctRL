//
//  MatchesRLCSContentViewController.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/19/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import Foundation
import Firebase
import RealmSwift

class MatchesContentViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!

	var category: Week?
	var matchesArray = [[Match]]()
	var matchesArrayRLCS = [[Match]]()
	var matchesArrayRLRS = [[Match]]()
	var matchesNA = [Match]()
	var matchesEU = [Match]()
	var matchesOCE = [Match]()
	var matchesSAM = [Match]()
	let lanNames = ["Day One", "Day Two", "Day Three", "Grand Finals"]
	let regionNamesRLCS = ["North America", "Europe", "Oceania", "South America"]
	let regionNamesRLRS = ["North America", "Europe"]
	var isRLCS = true
	
	var matchesRLCS: Results<RealmMatchRLCS>!
	var matchesRLRS: Results<RealmMatchRLRS>!
	
	let downloader = Downloader()
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	var headerTitle: String = ""
	
	// Mark: viewDidLoad()
	override func viewDidLoad() {
		super.viewDidLoad()
		setNeedsStatusBarAppearanceUpdate()
		
		matchesArrayRLCS.append(matchesNA)
		matchesArrayRLCS.append(matchesEU)
		matchesArrayRLCS.append(matchesOCE)
		matchesArrayRLCS.append(matchesSAM)
		
		matchesArrayRLRS.append(matchesNA)
		matchesArrayRLRS.append(matchesEU)
		
		configureRefreshControl()
		loadRLRSData()
		loadRLCSData()
		
		matchesArray = matchesArrayRLCS
		
		setRLCSListener()
		setRLRSListener()
		
		DispatchQueue.main.async{
			self.tableView.reloadData()
		}
	
		tableView.backgroundColor = UIColor(red: 40.0/255, green: 49.0/255, blue: 73.0/255, alpha: 1)
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 44
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .none
	}
	
	func configureRefreshControl () {
		// Add the refresh control to your UIScrollView object.
		tableView.refreshControl = UIRefreshControl()
		tableView.refreshControl?.addTarget(self, action:
			#selector(handleRefreshControl), for: .valueChanged)
	}
	
	@objc func handleRefreshControl() {
		self.reloadFirebaseData()
		// Dismiss the refresh control.
		DispatchQueue.main.async {
			self.tableView.refreshControl?.endRefreshing()
			self.tableView.reloadData()
		}
	}
	
	func loadRLCSData() {
		for i in 0..<regionNamesRLCS.count {
			self.matchesArrayRLCS[i].removeAll()
		}
		self.matchesNA.removeAll()
		self.matchesEU.removeAll()
		self.matchesOCE.removeAll()
		self.matchesSAM.removeAll()
		matchesRLCS = rlcsRealm.objects(RealmMatchRLCS.self).sorted(byKeyPath: "id")
		
		for realmMatch in matchesRLCS {
			var match = Match()
			
			match.id = realmMatch.id
			
			let teams = teamRealm.objects(RealmTeam.self).filter("id == '\(realmMatch.teamOneID)' OR id == '\(realmMatch.teamTwoID)'")
			
			
			var teamOneIndex = 0
			var teamTwoIndex = 1
			
			print("Teams: \(teams)")
			
			if teams[0].id != realmMatch.teamOneID {
				teamOneIndex = 1
				teamTwoIndex = 0
			}
			
			match.teamOneID = teams[teamOneIndex].abbreviatedName
			match.teamOne = teams[teamOneIndex].name
			match.teamOneColor = UIColor(hex: teams[teamOneIndex].backgroundColor)!
			
			match.teamTwoID = teams[teamTwoIndex].abbreviatedName
			match.teamTwo = teams[teamTwoIndex].name
			match.teamTwoColor = UIColor(hex: teams[teamTwoIndex].backgroundColor)!
			
			////////
			
			match.oneScore = realmMatch.oneScore
			match.twoScore = realmMatch.twoScore
			
			match.region = realmMatch.region
			
			match.week = match.setWeek(weekID: realmMatch.week)

			if match.week == self.category! {
				if match.region == 0 {
					matchesArrayRLCS[0].append(match)
				} else if match.region == 1 {
					matchesArrayRLCS[1].append(match)
				} else if match.region == 2 {
					matchesArrayRLCS[2].append(match)
				} else {
					matchesArrayRLCS[3].append(match)
				}
			}
			
			self.tableView.reloadData()
		}
	}
	
	func loadRLRSData() {
		for i in 0..<regionNamesRLRS.count {
			self.matchesArrayRLRS[i].removeAll()
		}
		matchesRLRS = rlrsRealm.objects(RealmMatchRLRS.self).sorted(byKeyPath: "id")
		
		for realmMatch in matchesRLRS {
			var match = Match()
			
			match.id = realmMatch.id
			
			let teams = teamRealm.objects(RealmTeam.self).filter("id == '\(realmMatch.teamOneID)' OR id == '\(realmMatch.teamTwoID)'")
			
			var teamOneIndex = 0
			var teamTwoIndex = 1
			
			if teams[0].id != realmMatch.teamOneID {
				teamOneIndex = 1
				teamTwoIndex = 0
			}
			
			match.teamOneID = teams[teamOneIndex].abbreviatedName
			match.teamOne = teams[teamOneIndex].name
			match.teamOneColor = UIColor(hex: teams[teamOneIndex].backgroundColor)!
			
			match.teamTwoID = teams[teamTwoIndex].abbreviatedName
			match.teamTwo = teams[teamTwoIndex].name
			match.teamTwoColor = UIColor(hex: teams[teamTwoIndex].backgroundColor)!
			
			match.oneScore = realmMatch.oneScore
			match.twoScore = realmMatch.twoScore
			
			match.region = realmMatch.region
			
			match.week = match.setWeek(weekID: realmMatch.week)

			if match.week == self.category! {
				if match.region == 3 {
					matchesArrayRLRS[0].append(match)
				} else if match.region == 4 {
					matchesArrayRLRS[1].append(match)
				}
			}
			
			self.tableView.reloadData()
		}
	}
	
	func setRLCSListener() {
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
			
			match.writeToRLCSRealm()
			
			self.loadRLCSData()
			self.tableView.reloadData()
		}
	}
	
	func setRLRSListener() {
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
			
			match.writeToRLRSRealm()
			
			self.loadRLRSData()
			self.tableView.reloadData()
		}
	}

	
	func reloadFirebaseData() {
		loadRLCSData()
		loadRLRSData()
		tableView.reloadData()
		print("Refresh RLCS Matches Download: Complete ✅" )
	}
}


/////////////////////////////////////////////

// MARK: Table View Delegate Methods

extension MatchesContentViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		if isRLCS {
			return regionNamesRLCS.count
		} else {
			return regionNamesRLRS.count
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return matchesArray[section].count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var match: Match
		
		match = matchesArray[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
		
		return cellSetup(forMatch: match)
	}
	
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 48
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 60
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		if isRLCS {
			return rlcsHeaderSetup(forSection: section)
		} else {
			return rlrsHeaderSetup(forSection: section)
		}
	}
	
	
	func cellSetup(forMatch match: Match) -> MatchesContentTableViewCell {
		
		// set the cell
		let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell") as! MatchesContentTableViewCell
		
		// Team Name Labels
		cell.teamOneLabel.text = match.teamOne.uppercased()
		cell.teamTwoLabel.text = match.teamTwo.uppercased()
		cell.teamOneLabel.textColor = UIColor.white
		cell.teamTwoLabel.textColor = UIColor.white
		
		// Team Logos
		let teamOneAbbr = match.teamOneID
		let teamTwoAbbr = match.teamTwoID
		
		if teamOneAbbr == "tbd" {
			cell.teamOneLogo.image = UIImage(named: "logo-null")
		} else {
			let urlString = "https://zacjohnson.xyz/boostctrl/logos/\(teamOneAbbr).png"
			cell.teamOneLogo.loadImageFromCacheWithUrlString(urlString: urlString)
		}
		
		if teamTwoAbbr == "tbd" {
			cell.teamTwoLogo.image = UIImage(named: "logo-null")
		} else {
			let urlString = "https://zacjohnson.xyz/boostctrl/logos/\(teamTwoAbbr).png"
			cell.teamTwoLogo.loadImageFromCacheWithUrlString(urlString: urlString)
		}
		
		cell.teamOneLogo.layer.cornerRadius = 4
		cell.teamTwoLogo.layer.cornerRadius = 4
		
		// Team Scores
		cell.teamOneScoreLabel.text = match.oneScore
		cell.teamTwoScoreLabel.text = match.twoScore
		
		// Cell Background color
		cell.teamOneBackground.backgroundColor = match.teamOneColor
		cell.teamTwoBackground.backgroundColor = match.teamTwoColor
		//cell.teamColorBackground.backgroundColor = UIColor.black
		
		return cell
	}
	
	func rlcsHeaderSetup(forSection section: Int) -> UIView {
		let view = UIView()
		view.backgroundColor = UIColor(red: 61.0 / 255, green: 66.0 / 255, blue: 77.0 / 255, alpha: 1.0)
		
		let label = UILabel()
		
		// Set label text based on TeamCategory
		if self.category != .championship {
			label.text = self.regionNamesRLCS[section]
		} else {
			label.text = self.lanNames[section]
		}
		
		label.textColor = UIColor.white
		
		// Set font
		if #available(iOS 8.2, *) {
			label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)
		} else {
			label.font = UIFont.systemFont(ofSize: 17)
		}
		
		label.sizeToFit()
		label.frame.origin = CGPoint(x: 18, y: 13)
		
		view.addSubview(label)
		
		return view
	}
	
	func rlrsHeaderSetup(forSection section: Int) -> UIView {
		let view = UIView()
		view.backgroundColor = UIColor(red: 61.0 / 255, green: 66.0 / 255, blue: 77.0 / 255, alpha: 1.0)
		
		let label = UILabel()
		
		// Set label text based on TeamCategory
		if self.category != .championship {
			label.text = self.regionNamesRLRS[section]
		} else {
			label.text = self.lanNames[section]
		}
		
		label.textColor = UIColor.white
		
		// Set font
		if #available(iOS 8.2, *) {
			label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)
		} else {
			label.font = UIFont.systemFont(ofSize: 17)
		}
		
		label.sizeToFit()
		label.frame.origin = CGPoint(x: 18, y: 13)
		
		view.addSubview(label)
		
		return view
	}
}

class MatchesContentTableViewCell: UITableViewCell {
	
	@IBOutlet weak var teamOneBackground: UIView!
	@IBOutlet weak var teamOneLabel: UILabel!
	@IBOutlet weak var teamOneLogo: UIImageView!
	@IBOutlet weak var teamOneScoreLabel: UILabel!
	@IBOutlet weak var teamTwoBackground: UIView!
	@IBOutlet weak var teamTwoLabel: UILabel!
	@IBOutlet weak var teamTwoLogo: UIImageView!
	@IBOutlet weak var teamTwoScoreLabel: UILabel!
}
