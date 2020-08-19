//
//  SecondViewController.swift
//  test
//
//  Created by Zac Johnson on 6/28/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import UIKit
import ACTabScrollView
import Firebase

class MatchesViewController: UIViewController, ACTabScrollViewDelegate, ACTabScrollViewDataSource {
	
	// MARK: Outlets

	@IBOutlet weak var rlcsTabScrollView: ACTabScrollView!
	@IBOutlet weak var leagueSwitch: UISegmentedControl!
	
	//////////////////////////////////////////////
	
	// MARK: Class Variables
	
	var isRLCS = true
	var contentViews: [UIView] = []
	
	//////////////////////////////////////////////

	// MARK: - View Methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tabViewSetup()
		setupMatchesVCs()
		
		if #available(iOS 13.0, *) {
			leagueSwitch.selectedSegmentTintColor(ctRLTheme.midnightBlue)
			leagueSwitch.unselectedSegmentTintColor(ctRLTheme.cloudWhite)
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		let downloader = Downloader()
		print("Reloading Matches 💜💜💜💜💜💜💜💜💜💜💜💜💜")
		downloader.reloadRLCSMatches()
		downloader.reloadRLRSMatches()
	}
	
	func tabViewSetup() {
		rlcsTabScrollView.defaultPage = 0
		rlcsTabScrollView.arrowIndicator = true
		rlcsTabScrollView.tabSectionBackgroundColor = UIColor(red: 40.0/255, green: 49.0/255, blue: 73.0/255, alpha: 1)
		rlcsTabScrollView.cachedPageLimit = 3
		rlcsTabScrollView.delegate = self
		rlcsTabScrollView.dataSource = self
	}
	
	//////////////////////////////////////////////
	
	// MARK: - Setup the Matches VCs. Each tab in the Matches section is it's own VC.
	func setupMatchesVCs() {
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		
		for category in Week.allValues() {
			let vc = storyboard.instantiateViewController(withIdentifier: "MatchesContentViewController") as! MatchesContentViewController
			
			vc.category = category
			vc.isRLCS = true
			
			addChildViewController(vc) // don't forget, it's very important
			contentViews.append(vc.view)
		}
	}
	
	//////////////////////////////////////////////
	
	// MARK: ACTabScrollViewDelegate
	func tabScrollView(_ tabScrollView: ACTabScrollView, didChangePageTo index: Int) {}
	
	func tabScrollView(_ tabScrollView: ACTabScrollView, didScrollPageTo index: Int) {}
	
	//////////////////////////////////////////////
	
	// MARK: ACTabScrollViewDataSource
	func numberOfPagesInTabScrollView(_ tabScrollView: ACTabScrollView) -> Int {
		return Week.allValues().count
	}
	
	func tabScrollView(_ tabScrollView: ACTabScrollView, tabViewForPageAtIndex index: Int) -> UIView {
		// create a label
		let label = UILabel()
		
		label.text = String(describing: Week.allValues()[index]).uppercased().replacingOccurrences(of: "_", with: " ")
		if #available(iOS 8.2, *) {
			label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.thin)
		} else {
			label.font = UIFont.systemFont(ofSize: 16)
		}
		
		label.textColor = UIColor.white
		label.textAlignment = .center
		
		// if the size of your tab is not fixed, you can adjust the size by the following way.
		label.sizeToFit() // resize the label to the size of content
		label.frame.size = CGSize(width: label.frame.size.width + 28, height: label.frame.size.height + 36) // add some paddings
		
		return label
	}
	
	func tabScrollView(_ tabScrollView: ACTabScrollView, contentViewForPageAtIndex index: Int) -> UIView {
		return contentViews[index]
	}

	//////////////////////////////////////////////
	
	// MARK: - Actions
	
	// This is the only way the UI wouldn't hang when switching between leagues. Before there were
	// two separate ACTabScrollView's for each league and that would hang the UI.
	@IBAction func leagueSwitchPressed(_ sender: Any) {
		
		switch leagueSwitch.selectedSegmentIndex {
		case 0: // Display RLCS Matches
			contentViews.removeAll()
			for vc in childViewControllers as! [MatchesContentViewController] {
				vc.isRLCS = true
                vc.seriesType = .championship
				vc.matchesArray = vc.matchesArrayRLCS
				vc.tableView.reloadData()
				contentViews.append(vc.view)
			}
		case 1: // Display RLRS Matches
			contentViews.removeAll()
			for vc in childViewControllers as! [MatchesContentViewController] {
				vc.isRLCS = false
                vc.seriesType = .rivals
				vc.loadRLRSData()
				vc.matchesArray = vc.matchesArrayRLRS
				vc.tableView.reloadData()
				contentViews.append(vc.view)
			}
		default:
			break
		}
		
	}
}

