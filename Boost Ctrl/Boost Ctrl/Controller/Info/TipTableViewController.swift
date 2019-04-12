//
//  TableViewController.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 4/10/19.
//  Copyright © 2019 Zac Johnson. All rights reserved.
//

import UIKit

protocol MessageCellDelegate {
	func dismissVC()
}

protocol TipTableViewControllerDelegate {
	func removeBlurredBackgroundView()
}

class TipTableViewController: UITableViewController {
	
	let IAPArray = [IAP(title: "Prospect Tip", description: "We all gotta start somewhere", price: "$0.99"),
					IAP(title: "Challenger Tip", description: "You're in the majority!", price: "$1.99"),
					IAP(title: "Superstar Tip", description: "You're teammates *are* holding you back", price: "$2.99"),
					IAP(title: "Champion Tip", description: "Sweet, blessed purple", price: "$3.99"),
					IAP(title: "Grand Champ Tip", description: "You're not a real GC anyway", price: "$4.99")
	]
	
	var blurDelegate: TipTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.delegate = self
		IAPService.shared.getProducts()
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch (indexPath.row) {
		case 0: break
		case 1:
			print("com.zacjohnson.BoostctRL.Prospect")
			IAPService.shared.purchase(product: .prospect)
		case 2:
			print("com.zacjohnson.BoostctRL.Challenger")
			IAPService.shared.purchase(product: .challenger)
		case 3:
			print("com.zacjohnson.BoostctRL.Star")
			IAPService.shared.purchase(product: .star)
		case 4:
			print("com.zacjohnson.BoostctRL.Champ")
			IAPService.shared.purchase(product: .champion)
		case 5:
			print("com.zacjohnson.BoostctRL.GC")
			IAPService.shared.purchase(product: .gc)
		default:
			print("Other")
		}
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch (indexPath.row) {
		case 0:
			return 190
		default:
			return 90
		}
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		print(indexPath.row)
		
		switch (indexPath.row) {
		case 0:
			let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
			cell.delegate = self
			return cell
		default:
			let cell = tableView.dequeueReusableCell(withIdentifier: "IAPCell", for: indexPath) as! IAPCell
			
			let iap = IAPArray[indexPath.row - 1]
			
			cell.priceLabel.text = iap.price
			cell.titleLabel.text = iap.title
			cell.descriptionLabel.text = iap.description
			
			return cell
		}
		
	}
	
	// MARK: - Actions
	
}

extension TipTableViewController: MessageCellDelegate {
	func dismissVC() {
		self.dismiss(animated: true, completion: nil)
		blurDelegate?.removeBlurredBackgroundView()
	}
}



class MessageCell: UITableViewCell {
	var delegate: MessageCellDelegate?
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	@IBAction func dismissButtonPressed(_ sender: Any) {
		print("here")
		delegate?.dismissVC()
	}
}

class IAPCell: UITableViewCell {
	@IBOutlet weak var prospectView: UIView!
	@IBOutlet weak var priceLabel: UILabel!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var greenView: UIView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		prospectView.layer.cornerRadius = 8
		greenView.layer.cornerRadius = 8
		greenView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
		
	}
}




