//
//  InfoViewController.swift
//  test
//
//  Created by Zac Johnson on 7/4/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, TipTableViewControllerDelegate  {
	
	// MARK: - Outlets
	
	@IBOutlet weak var settingsButton: UIButton!
	@IBOutlet weak var redditButton: UIButton!
	@IBOutlet weak var liquipediaButton: UIButton!
	@IBOutlet weak var octaneButton: UIButton!
	@IBOutlet weak var rocketeersButton: UIButton!
	@IBOutlet weak var tipButton: UIButton!
	@IBOutlet weak var twitterButton: UIButton!
	
	//////////////////////////////////////////////
	
	func overlayBlurredBackgroundView() {
		
		let mainWindow = UIApplication.shared.keyWindow!
		//let blurredBackgroundView = UIVisualEffectView(frame: CGRect(x: mainWindow.frame.origin.x, y: mainWindow.frame.origin.y, width: mainWindow.frame.width, height: mainWindow.frame.height))
		
		let blurredBackgroundView = UIVisualEffectView()
		blurredBackgroundView.frame = mainWindow.frame
		
		blurredBackgroundView.effect = UIBlurEffect(style: .dark)
		
		
		tabBarController?.view.addSubview(blurredBackgroundView)
		print("adding blur")
	}
	
	func removeBlurredBackgroundView() {
		print("removing blur")
		if let tabBar = tabBarController {
			for subview in tabBar.view.subviews {
				if subview.isKind(of: UIVisualEffectView.self) {
					subview.removeFromSuperview()
				}
			}
		}
	}
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let identifier = segue.identifier {
			if identifier == "ToTipScreen" {
				if let viewController = segue.destination as? TipTableViewController {
					viewController.blurDelegate = self
					viewController.modalPresentationStyle = .overFullScreen
				}
			}
		}
	}
	
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
		self.definesPresentationContext = true
		self.providesPresentationContextTransitionStyle = true
		print("pressed")
		self.overlayBlurredBackgroundView()
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
		settingsButton.layer.cornerRadius = settingsButton.frame.height / 2 - 10
		redditButton.layer.cornerRadius = redditButton.frame.height / 2 - 10
		liquipediaButton.layer.cornerRadius = liquipediaButton.frame.height / 2 - 10
		octaneButton.layer.cornerRadius = octaneButton.frame.height / 2 - 10
		rocketeersButton.layer.cornerRadius = rocketeersButton.frame.height / 2 - 10
		tipButton.layer.cornerRadius = tipButton.frame.height / 2 - 10
		twitterButton.layer.cornerRadius = twitterButton.frame.height / 2 - 10
	}
}
