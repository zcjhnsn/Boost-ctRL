//
//  NewsContentViewController.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/17/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import UIKit
import Firebase

protocol CustomNewsCellDelegate {
	
	func didTapNewsItem(url: String)
}

class NewsContentViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	var newsArray = [News]()
	var teamInfo: [Team] = []
	
	lazy var refresher: UIRefreshControl = {
		let refreshControl = UIRefreshControl()
		refreshControl.tintColor = .white
		refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
		
		return refreshControl
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
	
		if #available(iOS 10.0, *) {
			tableView.refreshControl = refresher
		} else {
			tableView.addSubview(refresher)
		}
		
		tableView.backgroundColor = UIColor(red: 40.0/255, green: 49.0/255, blue: 73.0/255, alpha: 1)
		configureTableView()
		retrieveNews()
		tableView.separatorStyle = .singleLine
	}
	
	@objc func refreshData() {
		let deadline = DispatchTime.now() + .milliseconds(500)
		DispatchQueue.main.asyncAfter(deadline: deadline) {
			self.retrieveNews()
		}
	}
	
	/////////////////////////////////////////////
	
	// MARK: Receive from Firebase
	func retrieveNews() {
		
		newsArray.removeAll()
		self.refresher.endRefreshing()
		let newsDB = Database.database().reference().child("news")
		
		newsDB.observe(.childAdded) {
			(snapshot) in
			
			let snapshotValue = snapshot.value as! Dictionary<String, String>
			
			let headline = snapshotValue["h"]!
			let detail = snapshotValue["d"]!
			let categoryString = snapshotValue["c"]!
			let link = snapshotValue["l"]!
			let siteName = snapshotValue["s"]!
			
			let news = News()
			news.headline = headline
			news.link = link
			news.detail = detail
			news.category = news.setCategory(category: categoryString)
			news.siteName = siteName
			
			self.newsArray.insert(news, at: 0)
			//self.newsArray.append(news)
			self.tableView.reloadData()
		}
		
		//self.newsArray.reverse()
		//self.tableView.reloadData()
	}
}

/////////////////////////////////////////////

// MARK: Table View Delegate Methods

extension NewsContentViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return newsArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! CustomNewsCell
		cell.setNews(news: newsArray[indexPath.row])
		cell.delegate = self
		
		
		cell.headlineLabel.text = newsArray[indexPath.row].headline
		
		return cell
	}
	
	func configureTableView() {
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 100.0
	}
}

/////////////////////////////////////////////

// MARK: CustomNewsCell Delegate Method

extension NewsContentViewController: CustomNewsCellDelegate {
	func didTapNewsItem(url: String) {
		if let link = URL(string: url) {
			UIApplication.shared.open(link, options: [:])
		}
	}
}

////////////////////////////////////////////

// MARK: CustomNewsCell Class

class CustomNewsCell: UITableViewCell {
	
	@IBOutlet weak var headlineLabel: UILabel!
	@IBOutlet weak var detailLabel: UILabel!
	@IBOutlet weak var categoryView: UIView!
	@IBOutlet weak var categoryLabel: UILabel!
	@IBOutlet weak var siteLabel: UILabel!
	
	var newsItem: News!
	var delegate: CustomNewsCellDelegate?
	
	func setNews(news: News) {
		newsItem = news
		headlineLabel.text = news.headline
		
		if news.detail == "none" {
			detailLabel.text = nil
			detailLabel.isHidden = true
		} else {
			detailLabel.text = news.detail			
		}
		
		siteLabel.text = news.siteName
		
		categoryLabel.text = String(describing: newsItem.category).replacingOccurrences(of: "_", with: " ")
		
		categoryView.layer.cornerRadius = 4
		categoryView.layer.borderWidth = 1
		categoryView.layer.borderColor = UIColor(hex: "FC214F")?.cgColor
	}
	
	@IBAction func newsButtonPressed(_ sender: UIButton) {
		delegate?.didTapNewsItem(url: newsItem.link)
	}
}
