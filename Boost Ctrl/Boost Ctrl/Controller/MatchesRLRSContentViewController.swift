//
//  MatchesRLRSContentViewController.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/19/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import Foundation
import Firebase

class MatchesRLRSContentViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	var matches = Matches()
	var category: Week?
	var matchesArray = [[Match]]()
	var matchesNA = [Match]()
	var matchesEU = [Match]()
	let lanNames = ["Day One", "Day Two", "Day Three"]
	let regionNames = ["North America", "Europe"]
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	var headerTitle: String = ""
	
	// Mark: viewDidLoad()
	override func viewDidLoad() {
		super.viewDidLoad()
		setNeedsStatusBarAppearanceUpdate()

		tableView.backgroundColor = UIColor(red: 40.0/255, green: 49.0/255, blue: 73.0/255, alpha: 1)
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 44
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .none
		
		if loadMatches() == true {
			tableView.reloadData()
		}
	}
	
	
	func showLoadingScreen() {
		let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
		
		let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
		loadingIndicator.hidesWhenStopped = true
		loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorView.Style.gray
		loadingIndicator.startAnimating();
		
		alert.view.addSubview(loadingIndicator)
		present(alert, animated: true, completion: nil)
	}
	
	func loadMatches() -> Bool {
		let standingsDB = Database.database().reference().child("matches/rlrs")
		
		
		standingsDB.observe(.childAdded) {
			(snapshot) in
			
			let snapshotValue = snapshot.value as! Dictionary<String, Any>
			
			var match = Match()
			
			match.teamOne = snapshotValue["t1name"]! as! String
			match.teamTwo = snapshotValue["t2name"]! as! String
			
			match.teamOneID = String(snapshotValue["t1id"]! as! Int)
			match.teamTwoID = String(snapshotValue["t2id"]! as! Int)
			
			match.teamOneColor = UIColor(hex: snapshotValue["t1color"]! as! String)!
			match.teamTwoColor = UIColor(hex: snapshotValue["t2color"]! as! String)!
			
			match.oneScore = String(snapshotValue["t1score"]! as! Int)
			match.twoScore = String(snapshotValue["t2score"]! as! Int)
			
			match.region = snapshotValue["region"]! as! Int
			let weekNumber = snapshotValue["week"]! as! Int
			match.week = match.setWeek(weekID: weekNumber)
			
			
			if match.week == self.category {
				
				if match.region == 3 {
					self.matchesNA.append(match)
				} else if match.region == 4 {
					self.matchesEU.append(match)
				}
			}
			self.matchesArray.removeAll()
			self.matchesArray.append(self.matchesNA)
			self.matchesArray.append(self.matchesEU)
			
			self.tableView.reloadData()
		}
		
		return true
	}
}


/////////////////////////////////////////////

// MARK: Table View Delegate Methods

extension MatchesRLRSContentViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return matchesArray.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return matchesArray[section].count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let match = matchesArray[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
		// set the cell
		let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell") as! MatchesContentTableViewCell
		
		// Team Name Labels
		cell.teamOneLabel.text = match.teamOne.uppercased()
		cell.teamTwoLabel.text = match.teamTwo.uppercased()
		cell.teamOneLabel.textColor = UIColor.white
		cell.teamTwoLabel.textColor = UIColor.white
		
		// Team Logos
		cell.teamOneLogo.image = UIImage(named: "logo-\(match.teamOneID)")
		cell.teamTwoLogo.image = UIImage(named: "logo-\(match.teamTwoID)")
		
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
	
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 48
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 60
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		let view = UIView()
		view.backgroundColor = UIColor(red: 61.0 / 255, green: 66.0 / 255, blue: 77.0 / 255, alpha: 1.0)
		
		let label = UILabel()
		
		// Set label text based on TeamCategory
		if self.category != .championship {
			label.text = self.regionNames[section]
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


