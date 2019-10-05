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
import FirebaseMessaging
import UserNotifications

var teamRealm = try! Realm()
var rlcsRealm = try! Realm()
var rlrsRealm = try! Realm()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var notificationCenter: UNUserNotificationCenter?
	
	let gcmMessageIDKey = "gcm.message_id"

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		// MARK: - Firebase setup
		FirebaseApp.configure()
		Database.database().isPersistenceEnabled = true
		
		//////////////////////////////////////////////
		
		// MARK: - Realm Migrations
		Realm.Configuration.defaultConfiguration = Realm.Configuration(
			schemaVersion: 2,
			migrationBlock: { migration, oldSchemaVersion in
				if oldSchemaVersion < 1 {
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
				if oldSchemaVersion < 2 {
					print("❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️ - Deleting Realm")
					migration.deleteData(forType: RealmMatchRLCS.className())
					migration.deleteData(forType: RealmMatchRLRS.className())
				}
			}, deleteRealmIfMigrationNeeded: true
		)
		
		
		//get application instance ID
		InstanceID.instanceID().instanceID { (result, error) in
			if let error = error {
				print("Error fetching remote instance ID: \(error)")
			} else if let result = result {
				print("Remote instance ID token: \(result.token)")
			}
		}
		
		//////////////////////////////////////////////
		
		downloadDataFromFirebase()	
		return true
	}
	
	func applicationWillResignActive(_ application: UIApplication) {}

	func applicationDidEnterBackground(_ application: UIApplication) {}

	func applicationWillEnterForeground(_ application: UIApplication) {}

	func applicationDidBecomeActive(_ application: UIApplication) {}
	
	func applicationSignificantTimeChange(_ application: UIApplication) {}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
	
	func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
		if let messageID = userInfo[gcmMessageIDKey] {
			print("Message ID: \(messageID)")
		}
		
		// Print full message.
		print(userInfo)
	}
	
	func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
		print("Unable to register for remote notifications: \(error.localizedDescription)")
	}

}


