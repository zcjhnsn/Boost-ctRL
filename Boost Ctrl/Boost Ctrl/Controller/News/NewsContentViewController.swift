//
//  NewsContentViewController.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/17/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift
import AlertOnboarding


protocol CustomNewsCellDelegate {
	func didTapNewsItem(url: String)
}

class NewsContentViewController: UIViewController {
	
	// MARK: - Outlets
	@IBOutlet weak var tableView: UITableView!
	
	
	//MARK: - Class Variables/Views
	var newsArray = [News]()
	let notificationManager = NotificationManager()
	
	lazy var refresher: UIRefreshControl = {
		let refreshControl = UIRefreshControl()
		refreshControl.tintColor = .white
		refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
		
		return refreshControl
	}()
	
	
	// MARK: - View Methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureTableView()
		retrieveNews()
		
		initialSetup()
		
	}
	
	// MARK: - Initial Setup
	
	private func initialSetup() {
		if let versionComponents = Bundle.main.releaseVersionNumber?.components(separatedBy: ".") {
			let majorMinor = "\(versionComponents[0]).\(versionComponents[1])"
			
			// Show update summary if first open after update
			if UserDefaults.standard.string(forKey: "AppVersionForUpdateSummary")?.contains(majorMinor) ?? true {
				notificationManager.registerForPushNotifications()
			} else {
				showUpdateSummary()
				cleanUpRealm()
				UserDefaults.standard.setValue(Bundle.main.releaseVersionNumberPretty, forKey: "AppVersionForUpdateSummary")
			}
		}
	}
	
	@objc func refreshData() {
		let deadline = DispatchTime.now() + .milliseconds(500)
		DispatchQueue.main.asyncAfter(deadline: deadline) {
			self.retrieveNews()
		}
	}
	
	
	private func configureTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 100.0
		tableView.backgroundColor = UIColor(red: 40.0/255, green: 49.0/255, blue: 73.0/255, alpha: 1)
		tableView.separatorStyle = .singleLine
		
		if #available(iOS 10.0, *) {
			tableView.refreshControl = refresher
		} else {
			tableView.addSubview(refresher)
		}
	}
	
	
	// MARK: - Onboarding
	
	private func showUpdateSummary() {
		
		// First, declare alerts
		let alerts = [Alert(image: #imageLiteral(resourceName: "notificationIcon"), title: "Notifications", text: "There's not enough pings in your life. Get notified about NA/EU final scores and breaking news. Subscribe to notifications you want and the ones you don't 👉 Three dots > Settings"), Alert(image: #imageLiteral(resourceName: "scoreboard"), title: "Game Results", text: "Sure, G2 went to game 5... But was it close? Did it go to overtime? Tap on a match to get the per-game scores."), Alert(image: #imageLiteral(resourceName: "updated"), title: "Auto-Refresh", text: "All matches and standings update in real-time without having to manually refresh the page. It's like having full boost, on demand."), Alert(image: #imageLiteral(resourceName: "coins"), title: "Contribute to development", text: "Help out with Boost ctRL's development so we can bring more features and pay for all these notifications you wanted 😉")]
	
		// Simply call AlertOnboarding...
		let alertView = AlertOnboarding(arrayOfAlerts: alerts)
		alertView.delegate = self
		
		alertView.colorForAlertViewBackground = ctRLTheme.midnightBlue
		alertView.colorButtonText = ctRLTheme.cloudWhite
		alertView.colorButtonBottomBackground = ctRLTheme.darkBlue
		alertView.colorPageIndicator = ctRLTheme.cloudWhite
		alertView.colorCurrentPageIndicator = ctRLTheme.hotPink
		
		
		// ... and show it !
		alertView.show()
	}
	
	// MARK: - Receive from Firebase
	private func retrieveNews() {
		
		newsArray.removeAll()
		self.refresher.endRefreshing()
		let newsDB = Database.database().reference().child("news")
		
		newsDB.observe(.childAdded) {
			(snapshot) in
			
			let snapshotValue = snapshot.value as! Dictionary<String, String>
			
            guard let headline = snapshotValue["h"],
                let detail = snapshotValue["d"],
                let categoryString = snapshotValue["c"],
                let link = snapshotValue["l"],
                let siteName = snapshotValue["s"] else {
                    return
            }
			
			let news = News()
			news.headline = headline
			news.link = link
			news.detail = detail
			news.category = news.setCategory(category: categoryString)
			news.siteName = siteName
			news.id = snapshot.key
			
			self.newsArray.insert(news, at: 0)
			self.tableView.reloadData()
		}
	}
	
	
	// MARK: - Analytics
	
	
	/// Sends data about news item tapped by user to Firebase Analytics
	///
	/// - Parameter news: news item
	private func logAnalyticsEvent(for news: News) {
		let params = [
			EventParameter.newsItemID : news.id,
			EventParameter.newsItemTitle : news.headline,
			EventParameter.newsSite : news.siteName
		]
		
		Analytics.logEvent(EventType.news, parameters: params)
	}
	
	// MARK: - Realm Cleanup
	
	/// Delete matches from previous season
	private func cleanUpRealm() {
		let realm = try? Realm()
		if let realm = realm {
			try? realm.write {
				realm.delete(realm.objects(RealmMatchRLCS.self))
				realm.delete(realm.objects(RealmMatchRLRS.self))
			} 
		}
	}
}


// MARK: - Table View Delegate/Data Source Methods

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
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let newsItem = newsArray[indexPath.row]
		logAnalyticsEvent(for: newsItem)
	}
}

// MARK: - CustomNewsCell Delegate Method

extension NewsContentViewController: CustomNewsCellDelegate {
	func didTapNewsItem(url: String) {
		if let link = URL(string: url) {
			UIApplication.shared.open(link, options: [:])
		}
	}
}

// MARK: - Alert View Delegate
extension NewsContentViewController: AlertOnboardingDelegate {
	func alertOnboardingSkipped(_ currentStep: Int, maxStep: Int) {
		notificationManager.registerForPushNotifications()
	}
	
	func alertOnboardingCompleted() {
		notificationManager.registerForPushNotifications()
	}
	
	func alertOnboardingNext(_ nextStep: Int) {

	}
	
}


// MARK: - CustomNewsCell Class

class CustomNewsCell: UITableViewCell {
	
	
	// MARK:  Cell Outlets
	
	@IBOutlet weak var headlineLabel: UILabel!
	@IBOutlet weak var detailLabel: UILabel!
	@IBOutlet weak var categoryView: UIView!
	@IBOutlet weak var categoryLabel: UILabel!
	@IBOutlet weak var siteLabel: UILabel!
	
	
	// MARK: Cell Variables
	
	var newsItem: News!
	var delegate: CustomNewsCellDelegate?
	
	
	// MARK: Cell Functions
	
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
	
	
	// MARK: Cell Actions
	
	@IBAction func newsButtonPressed(_ sender: UIButton) {
		delegate?.didTapNewsItem(url: newsItem.link)
	}
}
