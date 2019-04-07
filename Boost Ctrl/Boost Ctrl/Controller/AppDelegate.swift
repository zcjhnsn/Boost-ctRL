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
		// Override point for customization after application launch.
		FirebaseApp.configure()
		Database.database().isPersistenceEnabled = true
		
		
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

		
		
		
		downloadDataFromFirebase()
		
		return true
	}
	
	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
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





