//
//  InfoViewController.swift
//  test
//
//  Created by Zac Johnson on 7/4/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController  {
	
	// MARK: - Outlets
	
	@IBOutlet weak var redditButton: UIButton!
	@IBOutlet weak var liquipediaButton: UIButton!
	@IBOutlet weak var octaneButton: UIButton!
	@IBOutlet weak var rocketeersButton: UIButton!
	@IBOutlet weak var tipButton: UIButton!
	@IBOutlet weak var twitterButton: UIButton!
	
	//////////////////////////////////////////////
	
	// MARK: Actions
	
	// Open RL Esports subreddit in browser
	@IBAction func redditButtonPressed(_ sender: UIButton) {
		if let url = URL(string: "https://reddit.com/r/rocketleagueesports") {
			UIApplication.shared.open(url, options: [:])
		}
	}
	
	// Open liquipedia.net RL page in browser
	@IBAction func liquipediaButtonPressed(_ sender: UIButton) {
		if let url = URL(string: "https://liquipedia.net/rocketleague/Main_Page") {
			UIApplication.shared.open(url, options: [:])
		}
	}
	
	// Open octane.gg in browser
	@IBAction func octaneButtonPressed(_ sender: UIButton) {
		if let url = URL(string: "https://octane.gg") {
			UIApplication.shared.open(url, options: [:])
		}
	}
	
	// Open rocketeers.gg in browser
	@IBAction func rocketeersButtonPressed(_ sender: UIButton) {
		if let url = URL(string: "https://rocketeers.gg") {
			UIApplication.shared.open(url, options: [:])
		}
	}
	
	// Open discord invite link in broswer
	@IBAction func tipButtonPressed(_ sender: UIButton) {
		performSegue(withIdentifier: "ToTipScreen", sender: self)
	}
	
	// Open our twitter page in browser
	@IBAction func twitterButtonPressed(_ sender: UIButton) {
		if let url = URL(string: "https://twitter.com/boostctrl") {
			UIApplication.shared.open(url, options: [:])
		}
	}
	
	//////////////////////////////////////////////
	
	// MARK: - View Methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		redditButton.layer.cornerRadius = redditButton.frame.height / 2 - 10
		liquipediaButton.layer.cornerRadius = liquipediaButton.frame.height / 2 - 10
		octaneButton.layer.cornerRadius = octaneButton.frame.height / 2 - 10
		rocketeersButton.layer.cornerRadius = rocketeersButton.frame.height / 2 - 10
		tipButton.layer.cornerRadius = tipButton.frame.height / 2 - 10
		twitterButton.layer.cornerRadius = twitterButton.frame.height / 2 - 10
	}
}
