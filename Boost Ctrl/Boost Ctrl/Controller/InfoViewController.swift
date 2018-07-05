//
//  InfoViewController.swift
//  test
//
//  Created by Zac Johnson on 7/4/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController  {
	
	// MARK: Open discord invite link in broswer
	@IBAction func discordButtonPressed(_ sender: UIButton) {
		
		if let url = URL(string: "https://discord.gg/Y2Rkzpd") {
			UIApplication.shared.open(url, options: [:])
		}
	}
	
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
