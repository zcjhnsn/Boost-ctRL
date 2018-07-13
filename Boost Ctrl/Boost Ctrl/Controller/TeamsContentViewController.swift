//
//  TeamsContentViewController.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/11/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import UIKit

class TeamsContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var tableView: UITableView!
	
	var category: TeamCategory? {
		didSet {
			for team in Teams.teamArray.sorted(by: { $0.name < $1.name }) {
				if (team.category == category) {
					teamArray.append(team)
				}
			}
		}
	}
	var teamArray: [Team] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.backgroundColor = UIColor(red: 40.0/255, green: 49.0/255, blue: 73.0/255, alpha: 1)
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 44
		tableView.delegate = self
		tableView.dataSource = self
	}
	
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
		cell.teamLogo.image = UIImage(named: "logo-\(team.id)")
		cell.teamLogo.layer.cornerRadius = 4
		cell.teamNameLabel.text = team.name.uppercased()
		cell.teamNameLabel.textColor = UIColor.white
		cell.player1Label.text = String(describing: team.player1)
		cell.player1Label.textColor = UIColor.white
		cell.player2Label.text = String(describing: team.player2)
		cell.player2Label.textColor = UIColor.white
		cell.player3Label.text = String(describing: team.player3)
		cell.player3Label.textColor = UIColor.white
		cell.backgroundColor = team.backgroundColor
		
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 48
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 106
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let view = UIView()
		view.backgroundColor = UIColor(red: 61.0 / 255, green: 66.0 / 255, blue: 77.0 / 255, alpha: 1.0)
		
		let label = UILabel()
		
		label.text = "Season 6"
		label.textColor = UIColor.white
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

class TeamsContentTableViewCell: UITableViewCell {
	
	@IBOutlet weak var teamLogo: UIImageView!
	@IBOutlet weak var teamNameLabel: UILabel!
	@IBOutlet weak var playerNameView: UIView!
	@IBOutlet weak var player1Label: UILabel!
	@IBOutlet weak var player2Label: UILabel!
	@IBOutlet weak var player3Label: UILabel!
	
	
	override func awakeFromNib() {
		self.selectionStyle = .none
	}
}
