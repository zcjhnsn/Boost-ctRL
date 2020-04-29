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
import RealmSwift
import AlertOnboarding

class NewsContentViewController: UIViewController {
	
	
	//MARK: - Class Variables/Views
	let notificationManager = NotificationManager()
	
	var rocketeersArticles = [RocketeersArticle]()
    var octaneArticles = [OctaneArticle]()
    var players = [Player]()
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
        
        DispatchQueue.global().async {
            self.getRocketeersArticles()
            self.getOctaneArticles()
        }
        
        getPlayers()
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
				cleanUpRealm()
				UserDefaults.standard.setValue(Bundle.main.releaseVersionNumberPretty, forKey: "AppVersionForUpdateSummary")
			}
		} else {
			showUpdateSummary()
			cleanUpRealm()
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
		
		let urlString = "https://rocketeers.gg/wp-json/wp/v2/posts?per_page=10&_embed"
		
		if let url = URL(string: urlString) {
			if let data = try? Data(contentsOf: url) {
				let responseString = String(data: data, encoding: .utf8)
				self.parse(json: data, from: .rocketeers)
				return
			}
		}
    }
	
	func getOctaneArticles() {
		octaneArticles.removeAll()
		
		let urlString = "https://api.octane.gg/api/news_section"
		
		if let url = URL(string: urlString) {
			if let data = try? Data(contentsOf: url) {
				self.parse(json: data, from: .octane)
				return
			}
		}
	}
	
	func parse(json: Data, from site: Site) {
        let decoder = JSONDecoder()
        
        if site == .rocketeers {
            //decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let jsonArticles = try decoder.decode(RocketeersArticles.self, from: json)
                rocketeersArticles = jsonArticles
                var section = sections[1] as! RocketeersSection
                section.articles = rocketeersArticles
                sections[1] = section
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        } else if site == .octane {
            if let jsonArticles = try? decoder.decode(OctaneArticles.self, from: json) {
                octaneArticles = jsonArticles.data
				var section = sections[3] as! OctaneSection
				section.articles = octaneArticles
				sections[3] = section
            }
		} else if site == .twitch {
			if let jsonStreamers = try? decoder.decode(Streamers.self, from: json) {
				livePlayers = jsonStreamers.data
				var section = sections[5] as! TwitchSection
				section.streamers = livePlayers
				sections[5] = section
			}
		}
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
	
	
	/// Gets client ID for Twitch API. Since this may expire, the token should be grabbed from CloudKit in case it changes
	private func getClientID() {
        var zoneID: CKRecordZone.ID = CKRecordZone.ID()
        
        publicDB.fetchAllRecordZones { (zones, error) in
            if let zones = zones {
                zoneID = zones.first!.zoneID
            }
        }
        let pred = NSPredicate(value: true)
        //let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        let query = CKQuery(recordType: "Settings", predicate: pred)
        //query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["twitchClientID"]
        operation.resultsLimit = 1
        operation.zoneID = zoneID
        
        var newSettings = Settings()
        
        operation.recordFetchedBlock = { record in
            let settings = Settings()
            settings.twitchClientID = record["twitchClientID"]!
            newSettings = settings
        }
        
        operation.queryCompletionBlock = { [unowned self] (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    self.settings = newSettings
                    print(self.settings.twitchClientID)
                    self.getLivePlayers(from: self.players, withID: self.settings.twitchClientID)
                } else {
                    let ac = UIAlertController(title: "Fetch Failed", message: "There was an error fetching from CK: \(error!.localizedDescription)", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(ac, animated: true)
                }
            }
        }
    
		CKContainer(identifier: Constants.CloudKitID).publicCloudDatabase.add(operation)
    }
	
	/// Gets the Twitch names for pro players (stored in CloudKit)
	private func getPlayers() {
		players.removeAll()
		livePlayers.removeAll()
        var zoneID: CKRecordZone.ID = CKRecordZone.ID()
        
        publicDB.fetchAllRecordZones { (zones, error) in
            if let zones = zones {
				print(zones)
                zoneID = zones.first!.zoneID
            }
        }
        
        let pred = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "userLogin", ascending: false)
        let query = CKQuery(recordType: "Player", predicate: pred)
        
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["recordName", "userLogin"]
        operation.resultsLimit = 50
        operation.zoneID = zoneID
        
        print(CKRecordZone.default().zoneID)
        
        var newPlayers = [Player]()
        
        operation.recordFetchedBlock = { record in
            let player = Player()
            player.recordID = record.recordID
            player.id = record["recordName"]
            player.twitchName = record["userLogin"]
            newPlayers.append(player)
        }
        
        operation.queryCompletionBlock = { [unowned self] (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    NewsContentViewController.isDirty = false
                    self.players = newPlayers
                    self.getClientID()
                } else {
                    let ac = UIAlertController(title: "Player Fetch Failed", message: "There was an error fetching from CK: \(error!.localizedDescription)", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(ac, animated: true)
                }
            }
        }
        
		CKContainer(identifier: Constants.CloudKitID).publicCloudDatabase.add(operation)
    }
	
	
	/// Gets live players from Twitch
	/// - Parameters:
	///   - from: List of player names retrieved from `getPlayers()`
	///   - id: Twitch Client ID (API Key) retrieved from `getClientID()`
	private func getLivePlayers(from: [Player], withID id: String) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.twitch.tv"
        components.path = "/helix/streams"
        
        var queryItems = [URLQueryItem]()
        for player in players {
            queryItems.append(URLQueryItem(name: "user_login", value: player.twitchName))
        }
        components.queryItems = queryItems
                
        var request = URLRequest(url: components.url!)
        
        request.setValue(id, forHTTPHeaderField: "Client-ID")
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let _ = URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
			if let data = data {
			    if let jsonString = String(data: data, encoding: .utf8) {
                    print("🧡🧡🧡🧡🧡🧡🧡🧡🧡🧡 - \(jsonString)")
				    self.parse(json: data, from: .twitch)
			    }
			}
			else {
                print("Error: \(String(describing: error))")
            }
		}.resume()
        
        
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

extension NewsContentViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
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
