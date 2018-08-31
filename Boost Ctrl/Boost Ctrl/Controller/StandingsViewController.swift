//
//  StandingsViewController.swift
//  test
//
//  Created by Zac Johnson on 7/5/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import UIKit
import ACTabScrollView

class StandingsViewController: UIViewController, ACTabScrollViewDelegate, ACTabScrollViewDataSource {
	
	@IBOutlet weak var tabScrollView: ACTabScrollView!
	
	var contentViews: [UIView] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		// set ACTabScrollView, all the following properties are optional
		tabScrollView.defaultPage = 1
		tabScrollView.arrowIndicator = true
		//        tabScrollView.tabSectionHeight = 40
		tabScrollView.tabSectionBackgroundColor = UIColor(red: 40.0/255, green: 49.0/255, blue: 73.0/255, alpha: 1)
		//        tabScrollView.contentSectionBackgroundColor = UIColor.blue
		//        tabScrollView.tabGradient = true
		tabScrollView.pagingEnabled = true
		tabScrollView.cachedPageLimit = 3
		
		
		tabScrollView.delegate = self
		tabScrollView.dataSource = self
		
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		for category in TeamCategory.allValues() {
			let vc = storyboard.instantiateViewController(withIdentifier: "StandingsContentViewController") as! StandingsContentViewController
			vc.category = category
			
			addChildViewController(vc) // don't forget, it's very important
			contentViews.append(vc.view)
		}
		
		// set navigation bar appearance
		if let navigationBar = self.navigationController?.navigationBar {
			navigationBar.isTranslucent = false
			navigationBar.tintColor = UIColor.white
			navigationBar.barTintColor = UIColor(red: 64.0 / 255, green: 76.0 / 255, blue: 104.0 / 255, alpha: 1)
			navigationBar.titleTextAttributes = NSDictionary(object: UIColor.white, forKey: NSAttributedStringKey.foregroundColor as NSCopying) as? [NSAttributedStringKey : AnyObject]
			navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
			navigationBar.shadowImage = UIImage()
		}
		UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
	}
	
	// MARK: ACTabScrollViewDelegate
	func tabScrollView(_ tabScrollView: ACTabScrollView, didChangePageTo index: Int) {
		print(index)
	}
	
	func tabScrollView(_ tabScrollView: ACTabScrollView, didScrollPageTo index: Int) {
	}
	
	// MARK: ACTabScrollViewDataSource
	func numberOfPagesInTabScrollView(_ tabScrollView: ACTabScrollView) -> Int {
		return TeamCategory.allValues().count
	}
	
	func tabScrollView(_ tabScrollView: ACTabScrollView, tabViewForPageAtIndex index: Int) -> UIView {
		// create a label
		let label = UILabel()
		
		label.text = String(describing: TeamCategory.allValues()[index]).uppercased().replacingOccurrences(of: "_", with: " ")
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
		return contentViews[index]
	}

	
}
