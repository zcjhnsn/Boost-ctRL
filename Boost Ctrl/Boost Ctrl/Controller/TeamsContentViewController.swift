//
//  TeamsContentViewController.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/11/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import UIKit
import Firebase

class TeamsContentViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	var teams = Teams()
	var category: TeamCategory?
	var teamArray: [Team] = []
	var headerTitle: String = ""
	
	// Mark: viewDidLoad()
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor(red: 40.0/255, green: 49.0/255, blue: 73.0/255, alpha: 1)
		
		showLoadingScreen()
		if loadTeamsAndStandings() == true {
			tableView.reloadData()
			dismiss(animated: false, completion: nil)
		}
		
		tableView.backgroundColor = UIColor(red: 40.0/255, green: 49.0/255, blue: 73.0/255, alpha: 1)
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 44
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .none
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
	
	func loadTeamsAndStandings() -> Bool {
		self.teamArray.removeAll()

		let standingsDB = Database.database().reference().child("standings")

		standingsDB.observe(.childAdded) {
			(snapshot) in

			let snapshotValue = snapshot.value as! Dictionary<String, Any>

			var team = Team()

			team.id = String(snapshotValue["id"]! as! Int)
			print(team.id)
			team.region = snapshotValue["region"] as! Int
			team.name = snapshotValue["name"]! as! String
			team.category = team.setCategory(region: team.region)
			team.standing = snapshotValue["place"]! as! Int
			team.win = String(snapshotValue["win"]! as! Int)
			team.loss = String(snapshotValue["loss"]! as! Int)
			team.winPercentage = snapshotValue["wp"]! as! Int
			team.backgroundColor = UIColor(hex: snapshotValue["color"]! as! String)!
			team.player1 = snapshotValue["p1"]! as! String
			team.player2 = snapshotValue["p2"]! as! String
			team.player3 = snapshotValue["p3"]! as! String
			if team.category == self.category {
				self.teamArray.append(team)
				self.teamArray = self.teamArray.sorted(by: {$0.standing < $1.standing})
			}
			self.tableView.reloadData()
		}
		
		return true
	}
	
	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "TeamDetailSegue" {
			if let destination = segue.destination as? TeamDetailViewController {
				if let teamIndex = tableView.indexPathForSelectedRow?.row {
					destination.team = self.teamArray[teamIndex]
				}
			}
		}
	}

}


/////////////////////////////////////////////

// MARK: Table View Delegate Methods

extension TeamsContentViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return teamArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let team = teamArray[(indexPath as NSIndexPath).row]
		// set the cell
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TeamsContentTableViewCell
		
		// Standing Label
		cell.standingLabel.text = String(describing: team.standing)
		cell.standingLabel.textColor = UIColor.white
		
		// Team Logo
		if team.id == "2" {
			cell.teamLogo.image = UIImage(named: "logo-2b")
		} else {
			cell.teamLogo.image = UIImage(named: "logo-\(team.id)")
		}
		cell.teamLogo.layer.cornerRadius = 4
		
		// Team Label
		cell.teamNameLabel.text = team.name.uppercased()
		cell.teamNameLabel.textColor = UIColor.white
		
		// Win-Loss Label
		cell.winLossLabel.text = "\(team.win)-\(team.loss)"
		cell.winLossLabel.textColor = UIColor.white

		// Game-Diff Label
		
		
		if team.winPercentage > 0 {
			cell.gameDiffLabel.text = "(+\(team.winPercentage))"
			cell.gameDiffLabel.textColor = UIColor.green
		} else if team.winPercentage < 0 {
			cell.gameDiffLabel.text = "(\(team.winPercentage))"
			cell.gameDiffLabel.textColor = UIColor.red
		} else {
			cell.gameDiffLabel.text = "(\(team.winPercentage))"
			cell.gameDiffLabel.textColor = UIColor.lightGray
		}
		
		// Cell Background color
		//cell.teamColorBackground.backgroundColor = team.backgroundColor
		cell.teamColorBackground.backgroundColor = UIColor(red: 40.0/255, green: 49.0/255, blue: 73.0/255, alpha: 1)
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
		label.text = self.headerTitle
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
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let team = teamArray[indexPath.row]
		print("Team: \(team.name)")
	}
}

/////////////////////////////////////////////

// MARK: TeamsContent Table View Cell

class TeamsContentTableViewCell: UITableViewCell {
	
	@IBOutlet weak var standingLabel: UILabel!
	@IBOutlet weak var teamLogo: UIImageView!
	@IBOutlet weak var teamNameLabel: UILabel!
	@IBOutlet weak var teamColorBackground: UIView!
	@IBOutlet weak var winLossLabel: UILabel!
	@IBOutlet weak var gameDiffLabel: UILabel!
	
	override func awakeFromNib() {
		self.selectionStyle = .none
	}
}


