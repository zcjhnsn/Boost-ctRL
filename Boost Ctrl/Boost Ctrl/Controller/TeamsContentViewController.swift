//
//  TeamsContentViewController.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/11/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

class TeamsContentViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	var category: TeamCategory?
	var teamArray: [Team] = []
	var headerTitle: String = ""
	
	var teams: Results<RealmTeam>!
	
	let downloader = Downloader()
	
	// Mark: viewDidLoad()
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor(red: 40.0/255, green: 49.0/255, blue: 73.0/255, alpha: 1)
		
		loadData()
		
		tableView.backgroundColor = UIColor(red: 40.0/255, green: 49.0/255, blue: 73.0/255, alpha: 1)
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 44
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .none
		
		DispatchQueue.main.async{
			self.tableView.reloadData()
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		loadData()
	}
	
	func loadData() {
		self.teamArray.removeAll()
		teams = teamRealm.objects(RealmTeam.self)
		
		for realmTeam in teams {
			var team = Team()
			
			team.id = realmTeam.id
			team.abbr = realmTeam.abbreviatedName
			team.region = realmTeam.region
			team.name = realmTeam.name
			team.category = team.setCategory(region: team.region)
			team.standing = realmTeam.standing
			team.win = realmTeam.win
			team.loss = realmTeam.loss
			team.gameDifferential = realmTeam.gameDifferential
			team.backgroundColor = UIColor(hex: realmTeam.backgroundColor)!
			team.player1 = realmTeam.player1
			team.player2 = realmTeam.player2
			team.player3 = realmTeam.player3
			if team.category == self.category {
				self.teamArray.append(team)
				self.teamArray = self.teamArray.sorted(by: {$0.standing < $1.standing})
			}
			self.tableView.reloadData()
		}
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
		let abbr = team.abbr
		
		if abbr == "tbd" {
			cell.teamLogo.image = UIImage(named: "logo-null")
		} else {
			let urlString = "https://zacjohnson.xyz/boostctrl/logos/\(abbr).png"
			teamArray[(indexPath as NSIndexPath).row].logo = urlString
		cell.teamLogo.loadImageFromCacheWithUrlString(urlString: urlString)
		}
		
		cell.teamLogo.layer.cornerRadius = 4
		
		// Team Label
		cell.teamNameLabel.text = team.name.uppercased()
		cell.teamNameLabel.textColor = UIColor.white
		
		// Win-Loss Label
		cell.winLossLabel.text = "\(team.win)-\(team.loss)"
		cell.winLossLabel.textColor = UIColor.white

		// Game-Diff Label
		if team.gameDifferential > 0 {
			cell.gameDiffLabel.text = "(+\(team.gameDifferential))"
			cell.gameDiffLabel.textColor = UIColor.green
		} else if team.gameDifferential < 0 {
			cell.gameDiffLabel.text = "(\(team.gameDifferential))"
			cell.gameDiffLabel.textColor = UIColor.red
		} else {
			cell.gameDiffLabel.text = "(\(team.gameDifferential))"
			cell.gameDiffLabel.textColor = UIColor.lightGray
		}
		
		// Cell Background color
		cell.teamColorBackground.backgroundColor = UIColor(red: 40.0/255, green: 49.0/255, blue: 73.0/255, alpha: 1)
		
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


