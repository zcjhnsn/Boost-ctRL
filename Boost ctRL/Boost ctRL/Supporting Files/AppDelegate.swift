//
//  AppDelegate.swift
//  test
//
//  Created by Zac Johnson on 6/28/18.
//  Copyright © 2018 Zac Johnson. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

var teamRealm = try! Realm()
var rlcsRealm = try! Realm()
var rlrsRealm = try! Realm()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		// MARK: - Firebase setup
		FirebaseApp.configure()
		Database.database().isPersistenceEnabled = true
		
		//////////////////////////////////////////////
		
		// MARK: - Ream Migrations
		Realm.Configuration.defaultConfiguration = Realm.Configuration(
			schemaVersion: 1,
			migrationBlock: { migration, oldSchemaVersion in
				if (oldSchemaVersion < 1) {
					migration.enumerateObjects(ofType: RealmMatchRLCS.className()) { oldObject, newObject in
						// combine name fields into a single field
						newObject!["date"] = ""
						newObject!["title"] = ""
					}
					
					migration.enumerateObjects(ofType: RealmMatchRLRS.className(), { (oldMatch, newMatch) in
						newMatch!["date"] = ""
						newMatch!["title"] = ""
					})
				}
		})
		
		//////////////////////////////////////////////
		
		downloadDataFromFirebase()
		
		return true
	}
	
	func applicationWillResignActive(_ application: UIApplication) {}

	func applicationDidEnterBackground(_ application: UIApplication) {}

	func applicationWillEnterForeground(_ application: UIApplication) {}

	func applicationDidBecomeActive(_ application: UIApplication) {
		let downloader = Downloader()
		print("Aaaaaaaand we're back 🎾🎾🎾🎾🎾🎾🎾🎾🎾🎾")
		if downloader.loadTeamsAndStandings() {
			print("Returning Team Download Complete: ✅")
		} else {
			print("Returned False ‼️")
		}
		
		if downloader.loadMatches() {
			print("Returning Matches Download ✅")
		} else {
			print("Returning Matches Download 🔴")
		}
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}

}





