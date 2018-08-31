//
//  StandingsContentViewController.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/13/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

/////////////////////////////////////////////

// MARK: Import Statements

import Foundation
import UIKit

/////////////////////////////////////////////

// MARK: StandingsContent View Controller Class

class StandingsContentViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	var category: TeamCategory? {
		didSet {
			for team in Teams.teamArray.sorted(by: { $0.standing < $1.standing }) {
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
		tableView.separatorStyle = .none
		tableView.showsVerticalScrollIndicator = false
	}
}

/////////////////////////////////////////////

// MARK: Table View Delegate Methods

extension StandingsContentViewController: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return teamArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let team = teamArray[(indexPath as NSIndexPath).row]
		
		// set the cell
		let cell = tableView.dequeueReusableCell(withIdentifier: "StandingsCell") as! StandingsContentTableViewCell
		
		// Place label
		cell.placeNumberLabel.text = team.standing
		
		// Team Logo
		cell.teamLogo.image = UIImage(named: "logo-\(team.id)")
		cell.teamLogo.layer.cornerRadius = 4
		
		// Wins Label
		cell.winsLabel.textColor = UIColor.white
		cell.winsLabel.text = team.win
		
		// Losses Label
		cell.lossesLabel.textColor = UIColor.white
		cell.lossesLabel.text = team.loss
		
		// Win Percentage Label
		cell.winPercentageLabel.textColor = UIColor.white
		cell.winPercentageLabel.text = team.winPercentage
		
		// Cell background to Team Color
		cell.teamCellBackground.backgroundColor = team.backgroundColor
		
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

/////////////////////////////////////////////

// MARK: StandingsContent TableView Cell Class

class StandingsContentTableViewCell: UITableViewCell {
	
	@IBOutlet weak var placeNumberLabel: UILabel!
	@IBOutlet weak var teamLogo: UIImageView!
	@IBOutlet weak var winsLabel: UILabel!
	@IBOutlet weak var lossesLabel: UILabel!
	@IBOutlet weak var winPercentageLabel: UILabel!
	@IBOutlet weak var teamCellBackground: UIView!
	
	
	override func awakeFromNib() {
		self.selectionStyle = .none
	}
}
