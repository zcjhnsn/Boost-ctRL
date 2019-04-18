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

enum SeriesType {
    case championship
    case rivals
}

class MatchesContentViewController: UIViewController {
	
	// MARK: - Outlets
	
	@IBOutlet weak var tableView: UITableView!
	
	//////////////////////////////////////////////
	
	// MARK: Class Variables
	
	var isRLCS = true
	var headerTitle: String = ""
	
	let downloader = Downloader()

    var seriesType: SeriesType = .championship
	
	var notificationToken: NotificationToken? = nil

	// Week for each ACTabScrollView tab
	var category: Week?

	// Arrays for Matches (TableView sections)
	var matchesArray = [[Match]]()
	var matchesArrayRLCS = [[Match]]()
	var matchesArrayRLRS = [[Match]]()
	var matchesNA = [Match]()
	var matchesEU = [Match]()
	var matchesOCE = [Match]()
	var matchesSAM = [Match]()
	
	// TableView Section Header titles
	let lanNames = ["Day One", "Day Two", "Day Three", "Grand Finals"]
	let regionNamesRLCS = ["North America", "Europe", "Oceania", "South America"]
	let regionNamesRLRS = ["North America", "Europe"]
	
	//////////////////////////////////////////////
	
	// MARK: - Retrieve Realm Matches
	
	var matchesRLCS: Results<RealmMatchRLCS>!
	var matchesRLRS: Results<RealmMatchRLRS>!
	
	//////////////////////////////////////////////
	
	// Mark: View Methods
	
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
		
		realmListener()
		
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
	
	override func viewWillAppear(_ animated: Bool) {
		loadRLCSData()
		loadRLRSData()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		tableView.reloadData()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		notificationToken?.invalidate()
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	//////////////////////////////////////////////
	
	// MARK: - Pull to refresh
	
	func configureRefreshControl () {
		// Add the refresh control to your UIScrollView object.
		tableView.refreshControl = UIRefreshControl()
		tableView.refreshControl?.addTarget(self, action:
			#selector(handleRefreshControl), for: .valueChanged)
	}
	
	@objc func handleRefreshControl() {
        fetchDataFromFirebase { [weak self] in
            // Dismiss the refresh control.
            DispatchQueue.main.async {
                self?.tableView.refreshControl?.endRefreshing()
                self?.tableView.reloadData()
            }
        }
	}

    // Fetches the RLCS and RLRS matches from Firebase and completes when it's done
    func fetchDataFromFirebase(completion: @escaping () -> ()) {
        // TODO: I'm not sure why this is crashing on threadGroup.leave() but i'll look into it. For now the code below should work
        let threadGroup = DispatchGroup()

        threadGroup.enter()
        Downloader.fetchRLCSOnce {
            threadGroup.leave()
        }

        threadGroup.enter()
        Downloader.fetchRLRSOnce {
            threadGroup.leave()
        }

        threadGroup.notify(queue: .main) {
            switch self.seriesType {
            case .championship:
                self.loadRLCSData()
            case .rivals:
                self.loadRLRSData()
            }
            print("Refresh RLCS Matches Download: Complete ✅" )
            completion()
        }
    }
	
	//////////////////////////////////////////////
	
	// MARK: - Load Matches from Realm
	
	func loadRLCSData() {
		// Clear match arrays
		for i in 0..<regionNamesRLCS.count {
			self.matchesArrayRLCS[i].removeAll()
		}
		
		self.matchesNA.removeAll()
		self.matchesEU.removeAll()
		self.matchesOCE.removeAll()
		self.matchesSAM.removeAll()
		
		// Get Matches from Realm in sorted order
		matchesRLCS = rlcsRealm.objects(RealmMatchRLCS.self).sorted(byKeyPath: "id")
		
		for realmMatch in matchesRLCS {
			var match = Match()
			match.id = realmMatch.id
			
			// Query Realm for teams in this match
			let teams = teamRealm.objects(RealmTeam.self).filter("id == '\(realmMatch.teamOneID)' OR id == '\(realmMatch.teamTwoID)'")
			
			// set team1 and team2 based on Realm query
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
			
			// Configure match independent of team query
			
			match.oneScore = realmMatch.oneScore
			match.twoScore = realmMatch.twoScore
			
			match.region = realmMatch.region
			match.week = match.setWeek(weekID: realmMatch.week)
			
			match.date = realmMatch.date
			match.title = realmMatch.title

			// Assign to region
			if match.week == self.category! {
				if match.region == 0 {	// NA RLCS
					matchesArrayRLCS[0].append(match)
				} else if match.region == 1 { // EU RLCS
					matchesArrayRLCS[1].append(match)
				} else if match.region == 2 { // OCE RLCS
					matchesArrayRLCS[2].append(match)
				} else {	// SAM RLCS is 5
					matchesArrayRLCS[3].append(match)
				}
			}
            if seriesType == .championship {
                matchesArray = matchesArrayRLCS
            }
			
			self.tableView.reloadData()
		}
	}
	
	func loadRLRSData() {
		for i in 0..<regionNamesRLRS.count {
			self.matchesArrayRLRS[i].removeAll()
		}
		
		self.matchesNA.removeAll()
		self.matchesEU.removeAll()
		
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

			match.date = realmMatch.date
			match.title = realmMatch.title
			
			if match.week == self.category! {
				if match.region == 3 { // NA RLRS
					matchesArrayRLRS[0].append(match)
				} else if match.region == 4 { // EU RLRS
					matchesArrayRLRS[1].append(match)
				}
			}
            if seriesType == .rivals {
                matchesArray = matchesArrayRLRS
            }
			
			self.tableView.reloadData()
		}
	}
	
	func realmListener() {
		print("Listening")
		switch self.seriesType {
		case .championship:
			notificationToken = rlcsRealm.observe({ (notification, realm) in
				print("Change observed: \(notification)")
				self.loadRLCSData()
			})
		case .rivals:
			notificationToken = rlrsRealm.observe({ (notification, realm) in
				print("RLRS Change observed: \(notification)")
				self.loadRLRSData()
			})
		}
		
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
		return 80
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
		
		if match.teamOne.count == 12 && !match.teamOne.contains(" ") {
			cell.teamOneLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 11.5)
		}
		
		if match.teamTwo.count == 12 && !match.teamTwo.contains(" ") {
			cell.teamTwoLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 11.5)
		}
		
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
		
		// Date/Title/Time labels
		let dateTime = match.date.mountainToLocal().components(separatedBy: "-")
		
		cell.dateLabel.text = dateTime[0]
		cell.titleLabel.text = match.title
		cell.timeLabel.text = dateTime[1]
		
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

//////////////////////////////////////////////

// MARK: - MatchesContent TableViewCell

class MatchesContentTableViewCell: UITableViewCell {
	
	@IBOutlet weak var teamOneBackground: UIView!
	@IBOutlet weak var teamOneLabel: UILabel!
	@IBOutlet weak var teamOneLogo: UIImageView!
	@IBOutlet weak var teamOneScoreLabel: UILabel!
	@IBOutlet weak var teamTwoBackground: UIView!
	@IBOutlet weak var teamTwoLabel: UILabel!
	@IBOutlet weak var teamTwoLogo: UIImageView!
	@IBOutlet weak var teamTwoScoreLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
}
