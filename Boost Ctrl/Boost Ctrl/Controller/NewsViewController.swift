//
//  NewsViewController.swift
//  test
//
//  Created by Zac Johnson on 7/4/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON

// MARK: NewsCell Delegate
protocol NewsCellDelegate {
	func didPressCell(url: String)
}

class NewsViewController: UITableViewController {
	
	let NEWS_LINK = "https://boost-ctrl.firebaseio.com/news.json"
	var newsArray = [News]()
	let refreshCtrl = UIRefreshControl()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		self.refreshControl = refreshCtrl
	
		refreshCtrl.addTarget(self, action: #selector(refreshNewsData(_:)), for: .valueChanged)
		
		getNewsData(url: NEWS_LINK)
	}
	
	// MARK: Delegate methods
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return newsArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		print("cellForRowAt called")
		let news = newsArray[(indexPath as NSIndexPath).row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
		cell.headlineLabel.text = news.headline
		print("this is \(news.headline)")
		
		self.tableView.reloadData()
		return cell
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 77
	}
	
	@objc private func refreshNewsData(_ sender: Any) {
		// Fetch Weather Data
		getNewsData(url: "https://boost-ctrl.firebaseio.com/news.json")
		
		refreshCtrl.endRefreshing()
	}

	// MARK: Get data from api

	func getNewsData(url: String) {
		Alamofire.request(url, method: .get).responseJSON {
			response in
			if response.result.isSuccess {
				print("Success, news data obtained!")
				
				let newsJSON : JSON = JSON(response.result.value!)
				self.updateNewsData(json: newsJSON)
				
			} else {
				print(String(describing: response.result.error))
			}
		}
	}
	
	// MARK: Update newsArray with JSON data
	
	func updateNewsData(json: JSON) {
		self.newsArray.removeAll()
		
		for (key, subDataJSON): (String, JSON) in json {
			let id = "\(key)"
			let headline = subDataJSON["headline"].stringValue
			let link = subDataJSON["link"].stringValue
			let n = News(id: id, headline: headline, link: link)
			self.newsArray.append(n)
		}
		
		for news in newsArray.sorted(by: { $0.id > $1.id }) {
			newsArray.append(news)
		}
		
		for news in newsArray {
			print(news.headline)
		}
		
		
	}

}
	
	


// MARK: News struct

struct News {
	let id: String
	let headline: String
	let link: String
}

// MARK: News Cell

class NewsCell: UITableViewCell {

	@IBOutlet weak var headlineLabel: UILabel!
	
}



