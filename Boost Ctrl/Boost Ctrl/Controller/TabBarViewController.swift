//
//  TabBarViewController.swift
//  test
//
//  Created by Zac Johnson on 7/4/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.tabBarController?.selectedIndex = 1
	}
}
