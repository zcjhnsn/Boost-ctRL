//
//  TeamDetailViewController.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 1/29/19.
//  Copyright © 2019 Zac Johnson. All rights reserved.
//

import UIKit

class TeamDetailViewController: UIViewController {
	
	// MARK: - Outlets
	
	@IBOutlet weak var teamLogoImageView: UIImageView!
	@IBOutlet weak var teamNameLabel: UILabel!
	@IBOutlet weak var playerOneName: UILabel!
	@IBOutlet weak var playerTwoName: UILabel!
	@IBOutlet weak var playerThreeName: UILabel!
	@IBOutlet weak var teamStandingLabel: UILabel!
	@IBOutlet weak var winLossLabel: UILabel!
	@IBOutlet weak var gameDiffLabel: UILabel!
	
	//////////////////////////////////////////////
	
	// MARK: - Class Variables
	
	var team: Team?

	//////////////////////////////////////////////
	
	// MARK: - View Methods
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.navigationItem.largeTitleDisplayMode = .always
		self.navigationItem.title = "Team Info"
		
		if let safeTeam = team {
			// Team name and player labels
			teamNameLabel.text = safeTeam.name
			playerOneName.text = safeTeam.player1
			playerTwoName.text = safeTeam.player2
			playerThreeName.text = safeTeam.player3
			
			// Team logo
			if let logoURL = safeTeam.logo {
				teamLogoImageView.loadImageFromCacheWithUrlString(urlString: logoURL)
			} else {
				teamLogoImageView.image = UIImage(named: "logo-null")
			}
			
			// Team Standing + Region
			let place = String(describing: safeTeam.standing)
			let region = safeTeam.region
			teamStandingLabel.text = "#\(place) \(setRegion(regionID: region))"
			teamStandingLabel.textColor = UIColor.white
			
			// Win-Loss Label
			winLossLabel.text = "\(safeTeam.win)-\(safeTeam.loss)"
			winLossLabel.textColor = UIColor.white
			
			// Game-Diff Label
			if safeTeam.gameDifferential > 0 {
				gameDiffLabel.text = "(+\(safeTeam.gameDifferential))"
				gameDiffLabel.textColor = UIColor.green
			} else if safeTeam.gameDifferential < 0 {
				gameDiffLabel.text = "(\(safeTeam.gameDifferential))"
				gameDiffLabel.textColor = UIColor.red
			} else {
				gameDiffLabel.text = "(\(safeTeam.gameDifferential))"
				gameDiffLabel.textColor = UIColor.lightGray
			}
		}
    }
	
	//////////////////////////////////////////////
	
	// MARK: - Class Functions
	
	func setRegion(regionID: Int) -> String {
		switch regionID {
		case 0:
			return "NA RLCS"
		case 1:
			return "EU RLCS"
		case 2:
			return "OCE RLCS"
		case 3:
			return "NA RLRS"
		case 4:
			return "EU RLRS"
		case 5:
			return "SAM RLCS"
		default:
			return "NA RLCS"
		}
	}
}
