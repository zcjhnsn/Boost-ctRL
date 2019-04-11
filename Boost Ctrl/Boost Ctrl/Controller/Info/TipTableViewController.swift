//
//  TableViewController.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 4/10/19.
//  Copyright © 2019 Zac Johnson. All rights reserved.
//

import UIKit

class TipTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		IAPService.shared.getProducts()
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch (indexPath.row) {
		case 0: print("com.zacjohnson.BoostctRL.BronzeTip")
		case 1: print("com.zacjohnson.BoostctRL.Silver")
		case 2: print("com.zacjohnson.BoostctRL.Gold")
		case 3: print("com.zacjohnson.BoostctRL.Plat")
		case 4: print("com.zacjohnson.BoostctRL.Diamond")
		case 5: print("com.zacjohnson.BoostctRL.Champ")
		case 6: print("com.zacjohnson.BoostctRL.GC")
		default:
			print("Other")
		}
	}

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 7
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

}
