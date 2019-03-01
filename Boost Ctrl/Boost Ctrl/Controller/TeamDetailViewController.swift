//
//  TeamDetailViewController.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 1/29/19.
//  Copyright © 2019 Zac Johnson. All rights reserved.
//

import UIKit

class TeamDetailViewController: UIViewController {
	
	@IBOutlet weak var teamLogoImageView: UIImageView!
	@IBOutlet weak var teamNameLabel: UILabel!
	@IBOutlet weak var playerOneName: UILabel!
	@IBOutlet weak var playerTwoName: UILabel!
	@IBOutlet weak var playerThreeName: UILabel!
	@IBOutlet weak var teamStandingLabel: UILabel!
	
	var team: Team?

    override func viewDidLoad() {
        super.viewDidLoad()

		self.navigationItem.largeTitleDisplayMode = .always
		self.navigationItem.title = "Team Info"
		
		teamNameLabel.text = team?.name
		playerOneName.text = team?.player1
		playerTwoName.text = team?.player2
		playerThreeName.text = team?.player3
		//teamStandingLabel.text =
		
        // Do any additional setup after loading the view.
    }

//	func setStanding() -> String {
//		let region = team?.category
//		if region == .rlcs_NA {
//			return "NA"
//		} else if region == .rlcs_EU {
//			return "EU"
//		} else if region ==
//	}

}
