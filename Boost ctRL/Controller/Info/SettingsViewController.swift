//
//  SettingsViewController.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 4/30/19.
//  Copyright © 2019 Zac Johnson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging

class SettingsViewController: UIViewController {
	
	// MARK: - Outlets

	@IBOutlet weak var newsSwitch: UISwitch!
	@IBOutlet weak var matchResultsSwitch: UISwitch!
	
	// MARK: - Class variables
	
	override func viewDidLoad() {
        super.viewDidLoad()

        setSwitches()
    }
	
	func setSwitches() {
		let defaults = UserDefaults.standard
		let wantsNewsAlerts = defaults.bool(forKey: "newsAlerts")
		let wantsMatchesAlerts = defaults.bool(forKey: "matchAlerts")
		newsSwitch.isOn = wantsNewsAlerts
		matchResultsSwitch.isOn = wantsMatchesAlerts
	}
    
	// MARK: - Actions
	@IBAction func newsSwitchPressed(_ sender: Any) {
		if newsSwitch.isOn {
			Messaging.messaging().subscribe(toTopic: "news") { error in
				
				if let error = error {
					print("Failed to subscribe to news topic: \(error)")
				} else {
					print("Subscribed to news topic")
				}
				
			}
		} else {
			Messaging.messaging().unsubscribe(fromTopic: "news") { error in
				
				if let error = error {
					print("Failed to unsubscribe to news topic: \(error)")
				} else {
					print("Unsubscribed to news topic")
				}
				
			}
		}
	}
	
	@IBAction func matchResultsPressed(_ sender: Any) {
		if matchResultsSwitch.isOn {
			Messaging.messaging().subscribe(toTopic: "matchResults") { error in
				
				if let error = error {
					print("Failed to subscribe to match results topic: \(error)")
				} else {
					print("Subscribed to matches topic")
				}
			}
		} else {
			
			Messaging.messaging().unsubscribe(fromTopic: "matchResults") { error in
				
				if let error = error {
					print("Failed to unsubscribe to match results topic: \(error)")
				} else {
					print("Unsubscribed to matches topic")
				}
			}
		}
		
	}
}
