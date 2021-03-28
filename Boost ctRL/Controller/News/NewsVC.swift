//
//  NewsContentViewController.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/17/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import UIKit
import CloudKit
import Firebase
import AlertOnboarding

class NewsVC: UIViewController {
	
	//MARK: - Class Variables/Views
	let notificationManager = NotificationManager()
	
	var rocketeersArticles = [RocketeersArticle]()
    var octaneArticles = [OctaneArticle]()
    static var isDirty = true
    var settings = Settings()
    var livePlayers = [Streamer]()
	
	let publicDB = CKContainer(identifier: Constants.CloudKitID).publicCloudDatabase
	
	var sections: [Section] = [
		TitleSection(title: "Rocketeers", imageNamed: "rocketeersLogo"),
		RocketeersSection(),
		TitleSection(title: "Octane", imageNamed: "octaneLogo"),
		OctaneSection(),
        TitleSection(title: "Who's Live ", imageNamed: "twitchLogo"),
        TwitchSection()
	]
	
	lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
		collectionView.backgroundColor = ctRLTheme.midnightBlue
		collectionView.showsVerticalScrollIndicator = false
		collectionView.isPrefetchingEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
		
		collectionView.register(TitleCell.self, forCellWithReuseIdentifier: TitleCell.defaultReuseIdentifier)
		collectionView.register(RocketeersCell.self, forCellWithReuseIdentifier: RocketeersCell.defaultReuseIdentifier)
		collectionView.register(BlankRocketeersCell.self, forCellWithReuseIdentifier: BlankRocketeersCell.defaultReuseIdentifier)
		collectionView.register(OctaneCell.self, forCellWithReuseIdentifier: OctaneCell.defaultReuseIdentifier)
		collectionView.register(BlankOctaneCell.self, forCellWithReuseIdentifier: BlankOctaneCell.defaultReuseIdentifier)
		collectionView.register(TwitchCell.self, forCellWithReuseIdentifier: TwitchCell.defaultReuseIdentifier)
		
		collectionView.usesAutoLayout()
        
        return collectionView
    }()
	
	lazy var collectionViewLayout: UICollectionViewLayout = {
        var sections = self.sections
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return sections[sectionIndex].layoutSection()
        }
        return layout
    }()
	
	
	// MARK: - View Methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initialSetup()
		setupCollectionView()
		view.backgroundColor = ctRLTheme.midnightBlue
        
		getRocketeersArticles()
		getOctaneArticles()
		getTwitchTokens()
	}
	
	override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 13.0, *) {
            // Workaround for incorrect initial offset by `.groupPagingCentered`
            collectionView.reloadData()
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if #available(iOS 13.0, *) {
            // Workaround for incorrect initial offset by `.groupPagingCentered`
        }
    }
	
	func setupCollectionView() {
		view.addSubview(collectionView)
		
		collectionView.fillSuperview()
	}
	
	// MARK: - Initial Setup
	
	private func initialSetup() {
		if let versionComponents = Bundle.main.releaseVersionNumber?.components(separatedBy: ".") {
			let majorMinor = "\(versionComponents[0]).\(versionComponents[1])"
			
			// Show update summary if first open after update
			if let version = UserDefaults.standard.string(forKey: "AppVersionForUpdateSummary"), version.contains(majorMinor) {
				notificationManager.registerForPushNotifications()
			} else {
				showUpdateSummary()
				UserDefaults.standard.setValue(Bundle.main.releaseVersionNumberPretty, forKey: "AppVersionForUpdateSummary")
			}
		} else {
			showUpdateSummary()
			UserDefaults.standard.setValue(Bundle.main.releaseVersionNumberPretty, forKey: "AppVersionForUpdateSummary")
		}
	}
	
	
	// MARK: - Onboarding
	
	private func showUpdateSummary() {
		
		// First, declare alerts
		let alerts = [Alert(image: #imageLiteral(resourceName: "newspaper"), title: "Revamped News Feed", text: "Keep up on the latest news as it breaks courtesy of Rocketeers.gg and Octane.gg"),Alert(image: #imageLiteral(resourceName: "twitchLogo"), title: "Watch the Pros", text: "Don't just watch the pros on the weekend. See when the pros are live on Twitch during the week. !prime")]
	
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
	
	// MARK: - Retrieve Data
	func getRocketeersArticles() {
        // https://medium.com/flawless-app-stories/writing-network-layer-in-swift-protocol-oriented-approach-4fa40ef1f908
		rocketeersArticles.removeAll()
		
		API.request(router: Router.getNewsRocketeers) { (result: Result<[RocketeersArticle], Error>) in
			switch result {
			case .success(let articles):
				var section = self.sections[1] as! RocketeersSection
                section.articles = articles
				self.sections[1] = section
				self.collectionView.reloadData()

			case .failure(let error):
				print(error.localizedDescription)
			}
		}
    }
	
	func getOctaneArticles() {
		octaneArticles.removeAll()
		
		API.request(router: Router.getNewsOctane) { (result: Result<OctaneArticles, Error>) in
			switch result {
			case .success(let articles):
				var section = self.sections[3] as! OctaneSection
				section.articles = articles.data
				self.sections[3] = section
				self.collectionView.reloadData()
				
			case .failure(let error):
				print("😔")
				print(error.localizedDescription)
			}
		}
	
	}
	
	
	/// Gets client ID for Twitch API. Since this may expire, the token should be grabbed from CloudKit in case it changes
	private func getTwitchTokens() {
        var zoneID: CKRecordZone.ID = CKRecordZone.ID()
        
        publicDB.fetchAllRecordZones { (zones, error) in
			if let firstZone = zones?.first {
                zoneID = firstZone.zoneID
            }
        }
        let pred = NSPredicate(value: true)
        let query = CKQuery(recordType: "Settings", predicate: pred)
        
        let operation = CKQueryOperation(query: query)
		operation.desiredKeys = [Constants.TwitchClientID, Constants.TwitchClientSecret]
        operation.resultsLimit = 1
        operation.zoneID = zoneID
        
        var newSettings = Settings()
		var twitchTokens = [URLQueryItem]()
        
        operation.recordFetchedBlock = { record in
            let settings = Settings()
			settings.twitchClientID = record[Constants.TwitchClientID]
			settings.twitchClientSecret = record[Constants.TwitchClientSecret]
			
            newSettings = settings
			
			if let id = settings.twitchClientID, let secret = settings.twitchClientSecret {
				twitchTokens.append(URLQueryItem(name: "client_id", value: id))
				twitchTokens.append(URLQueryItem(name: "client_secret", value: secret))
				twitchTokens.append(URLQueryItem(name: "grant_type", value: "client_credentials"))
			}
        }
        
        operation.queryCompletionBlock = { [unowned self] (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    self.settings = newSettings
					
					if !twitchTokens.isEmpty {
						API.request(router: Router.getAppAccessToken, queryItems: twitchTokens) { (result: Result<TwitchTokenResponse, Error>) in
							switch result {
							case .success(let response):
								self.settings.twitchAppAccessToken = response.accessToken
								self.getLiveStreams()
								
							case .failure(let error):
								print(error.localizedDescription)
							}
						}
					}
                } else {
                    let ac = UIAlertController(title: "Fetch Failed", message: "There was an error fetching from CK: \(error!.localizedDescription)", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(ac, animated: true)
                }
            }
        }
    
		CKContainer(identifier: Constants.CloudKitID).publicCloudDatabase.add(operation)
    }
	
	
	private func getLiveStreams() {
		var parameters = [URLQueryItem]()
		if let id = settings.twitchClientID, let token = settings.twitchAppAccessToken {
			parameters.append(URLQueryItem(name: "Client-ID", value: id))
			parameters.append(URLQueryItem(name: "Authorization", value: "Bearer \(token)"))
			parameters.append(URLQueryItem(name: "game_id", value: Constants.TwitchIDForRL))
	
			API.twitchRequest(router: Router.getLivePlayers, clientID: id, token: token) { (result: Result<Streamers, Error>) in
				switch result {
				case .success(let streamers):
					var section = self.sections[5] as! TwitchSection
					section.streamers = streamers.data
					self.sections[5] = section
				case .failure(let error):
					print(error.localizedDescription)
				}
			}
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
	
}

extension NewsVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return sections[indexPath.section].configureCell(collectionView: collectionView, indexPath: indexPath)
    }
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let url = sections[indexPath.section].handleSelection(collectionView: collectionView, indexPath: indexPath)
		if let link = URL(string: url) {
			UIApplication.shared.open(link, options: [:])
		}
	}
}



// MARK: - Alert View Delegate
extension NewsVC: AlertOnboardingDelegate {
	func alertOnboardingSkipped(_ currentStep: Int, maxStep: Int) {
		notificationManager.registerForPushNotifications()
	}
	
	func alertOnboardingCompleted() {
		notificationManager.registerForPushNotifications()
	}
	
	func alertOnboardingNext(_ nextStep: Int) {

	}
	
}
