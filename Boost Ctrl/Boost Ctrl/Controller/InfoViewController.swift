//
//  InfoViewController.swift
//  test
//
//  Created by Zac Johnson on 7/4/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController  {
	
	// MARK: Open RL Esports subreddit in browser
	@IBAction func redditButtonPressed(_ sender: UIButton) {
		if let url = URL(string: "https://reddit.com/r/rocketleagueesports") {
			UIApplication.shared.open(url, options: [:])
		}
	}
	
	// MARK: Open liquipedia.net RL page in browser
	@IBAction func liquipediaButtonPressed(_ sender: UIButton) {
		if let url = URL(string: "https://liquipedia.net/rocketleague/Main_Page") {
			UIApplication.shared.open(url, options: [:])
		}
	}
	
	// MARK: Open octane.gg in browser
	@IBAction func octaneButtonPressed(_ sender: UIButton) {
		if let url = URL(string: "https://octane.gg") {
			UIApplication.shared.open(url, options: [:])
		}
	}
	
	// MARK: Open rocketeers.gg in browser
	@IBAction func rocketeersButtonPressed(_ sender: UIButton) {
		if let url = URL(string: "https://rocketeers.gg") {
			UIApplication.shared.open(url, options: [:])
		}
	}
	
	// MARK: Open discord invite link in broswer
	@IBAction func discordButtonPressed(_ sender: UIButton) {
		if let url = URL(string: "https://discord.gg/Y2Rkzpd") {
			UIApplication.shared.open(url, options: [:])
		}
	}
	
	// MARK: Open our twitter page in browser
	@IBAction func twitterButtonPressed(_ sender: UIButton) {
		if let url = URL(string: "https://twitter.com/boostctrl") {
			UIApplication.shared.open(url, options: [:])
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
}
