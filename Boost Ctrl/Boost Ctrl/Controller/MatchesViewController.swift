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

	@IBOutlet weak var rlcsTabScrollView: ACTabScrollView!
	@IBOutlet weak var rlrsTabScrollView: ACTabScrollView!
	@IBOutlet weak var leagueSwitch: UISegmentedControl!
	
	
	var isRLCS = true
	var contentViews: [UIView] = []
	var rlrsContentViews: [UIView] = []
	
	var matchesRLCSArray = [[Match]]()
	var matchesNARLCS = [Match]()
	var matchesEURLCS = [Match]()
	var matchesOCERLCS = [Match]()
	
	var matchesRLRSArray = [[Match]]()
	var matchesNARLRS = [Match]()
	var matchesEURLRS = [Match]()
	var matchesOCERLRS = [Match]()
	
	
	@IBAction func leagueSwitchPressed(_ sender: Any) {
		
		switch leagueSwitch.selectedSegmentIndex {
		case 0:
			rlcsTabScrollView.isHidden = false
			rlrsTabScrollView.isHidden = true
			isRLCS = true
		case 1:
			rlcsTabScrollView.isHidden = true
			rlrsTabScrollView.isHidden = false
			isRLCS = false
		default:
			break
		}
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		// set ACTabScrollView, all the following properties are optional
		
		rlrsTabScrollView.isHidden = true
		rlcsTabScrollView.isHidden = false
		
		if loadRLCSMatches() {
			rlcsTabViewSetup()
			setupRLCS()
		}
		
		rlrsTabViewSetup()
		setupRLRS()
		
		// set navigation bar appearance
		if let navigationBar = self.navigationController?.navigationBar {
			navigationBar.isTranslucent = false
			navigationBar.tintColor = UIColor.white
			navigationBar.barTintColor = UIColor(red: 64.0 / 255, green: 76.0 / 255, blue: 104.0 / 255, alpha: 1)
			navigationBar.titleTextAttributes = NSDictionary(object: UIColor.white, forKey: NSAttributedStringKey.foregroundColor as NSCopying) as? [NSAttributedStringKey : AnyObject]
			navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
			navigationBar.shadowImage = UIImage()
		}
	}
	
	func rlcsTabViewSetup() {
		rlcsTabScrollView.defaultPage = 0
		rlcsTabScrollView.arrowIndicator = true
		rlcsTabScrollView.tabSectionBackgroundColor = UIColor(red: 40.0/255, green: 49.0/255, blue: 73.0/255, alpha: 1)
		rlcsTabScrollView.pagingEnabled = true
		rlcsTabScrollView.cachedPageLimit = 3
		rlcsTabScrollView.delegate = self
		rlcsTabScrollView.dataSource = self
	}
	
	func rlrsTabViewSetup() {
		rlrsTabScrollView.defaultPage = 0
		rlrsTabScrollView.arrowIndicator = true
		rlrsTabScrollView.tabSectionBackgroundColor = UIColor(red: 40.0/255, green: 49.0/255, blue: 73.0/255, alpha: 1)
		rlrsTabScrollView.pagingEnabled = true
		rlrsTabScrollView.cachedPageLimit = 3
		rlrsTabScrollView.delegate = self
		rlrsTabScrollView.dataSource = self
		
	}
	
	func setupRLCS() {
		contentViews.removeAll()
		
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		
		for category in Week.allValues() {
			let vc = storyboard.instantiateViewController(withIdentifier: "MatchesRLCSContentViewController") as! MatchesRLCSContentViewController
			vc.category = category
			vc.matchesArray = matchesRLCSArray
			vc.matchesNA = matchesNARLCS
			vc.matchesEU = matchesEURLCS
			vc.matchesOCE = matchesOCERLCS
			
			addChildViewController(vc) // don't forget, it's very important
			contentViews.append(vc.view)
			print("num: \(contentViews.count)")
		}
	}
	
	func setupRLRS() {
		rlrsContentViews.removeAll()
		
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		
		for category in Week.allValues() {
			let vc = storyboard.instantiateViewController(withIdentifier: "MatchesRLRSContentViewController") as! MatchesRLRSContentViewController
			vc.category = category
			
			addChildViewController(vc) // don't forget, it's very important
			rlrsContentViews.append(vc.view)
		}
	}
	
	func loadRLCSMatches(category: Week) -> Bool {
		self.matchesRLCSArray.removeAll()
		
		let standingsDB = Database.database().reference().child("matches/rlcs")
		
		
		standingsDB.observe(.childAdded) {
			(snapshot) in
			
			let snapshotValue = snapshot.value as! Dictionary<String, Any>
			
			var match = Match()
			
			match.teamOne = snapshotValue["t1name"]! as! String
			match.teamTwo = snapshotValue["t2name"]! as! String
			
			match.teamOneID = String(snapshotValue["t1id"]! as! Int)
			match.teamTwoID = String(snapshotValue["t2id"]! as! Int)
			
			match.teamOneColor = UIColor(hex: snapshotValue["t1color"]! as! String)!
			match.teamTwoColor = UIColor(hex: snapshotValue["t2color"]! as! String)!
			
			match.oneScore = String(snapshotValue["t1score"]! as! Int)
			match.twoScore = String(snapshotValue["t2score"]! as! Int)
			
			match.region = snapshotValue["region"]! as! Int
			let weekNumber = snapshotValue["week"]! as! Int
			match.week = match.setWeek(weekID: weekNumber)
			
			
			if match.week == category {
				
				if match.region == 0 {
					self.matchesNARLCS.append(match)
				} else if match.region == 1 {
					self.matchesEURLCS.append(match)
				} else {
					self.matchesOCERLCS.append(match)
				}
			}
			
			self.matchesRLCSArray.removeAll()
			self.matchesRLCSArray.append(self.matchesNARLCS)
			self.matchesRLCSArray.append(self.matchesEURLCS)
			self.matchesRLCSArray.append(self.matchesOCERLCS)
			
			print("Loaded Week \(match.week): \(match.teamOne) vs \(match.teamTwo)")
		}
		
		return true
	}
	
	// MARK: ACTabScrollViewDelegate
	func tabScrollView(_ tabScrollView: ACTabScrollView, didChangePageTo index: Int) {
		print(index)
	}
	
	func tabScrollView(_ tabScrollView: ACTabScrollView, didScrollPageTo index: Int) {
	}
	
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
		// label.textColor = UIColor(red: 77.0 / 255, green: 79.0 / 255, blue: 84.0 / 255, alpha: 1)
		label.textColor = UIColor.white
		label.textAlignment = .center
		
		// if the size of your tab is not fixed, you can adjust the size by the following way.
		label.sizeToFit() // resize the label to the size of content
		label.frame.size = CGSize(width: label.frame.size.width + 28, height: label.frame.size.height + 36) // add some paddings
		
		return label
	}
	
	func tabScrollView(_ tabScrollView: ACTabScrollView, contentViewForPageAtIndex index: Int) -> UIView {
		if isRLCS {
			return contentViews[index]
		} else {
			return rlrsContentViews[index]
		}

	}


	

}

