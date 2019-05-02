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
		
		Messaging.messaging().delegate = self
		UNUserNotificationCenter.current().delegate = self
		
		registerForPushNotifications()
		
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

extension AppDelegate: UNUserNotificationCenterDelegate{
	func userNotificationCenter(_ center: UNUserNotificationCenter,
								willPresent notification: UNNotification,
								withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
		let userInfo = notification.request.content.userInfo
		
		// With swizzling disabled you must let Messaging know about the message, for Analytics
		// Messaging.messaging().appDidReceiveMessage(userInfo)
		// Print message ID.
		if let messageID = userInfo[gcmMessageIDKey] {
			print("Message ID: \(messageID)")
		}
		
		// Print full message.
		print(userInfo)
		
		// Change this to your preferred presentation option
		completionHandler([])
	}
	
	func userNotificationCenter(_ center: UNUserNotificationCenter,
								didReceive response: UNNotificationResponse,
								withCompletionHandler completionHandler: @escaping () -> Void) {
		let userInfo = response.notification.request.content.userInfo
		// Print message ID.
		if let messageID = userInfo[gcmMessageIDKey] {
			print("Message ID: \(messageID)")
		}
		
		// Print full message.
		print(userInfo)
		
		completionHandler()
	}
	
	func registerForPushNotifications() {
		let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
		
		//Solicit permission from user to receive notifications
		UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { [weak self] granted, error in
			let defaults = UserDefaults.standard
			defaults.set(granted, forKey: "newsAlerts")
			defaults.set(granted, forKey: "matchAlerts")
			
			print("permission granted")
			guard granted else { return }
			self?.getNotificationSettings()
		}
	}
	
	func getNotificationSettings() {
		UNUserNotificationCenter.current().getNotificationSettings { settings in
			print("Notification settings: \(settings)")
			
			guard settings.authorizationStatus == .authorized else { return }
			DispatchQueue.main.async {
				UIApplication.shared.registerForRemoteNotifications()
			}
			
			Messaging.messaging().subscribe(toTopic: "news") { error in
				
				if let error = error {
					print("Failed to subscribe to news topic")
				} else {
					print("Subscribed to news topic")
				}
				
			}
			
			Messaging.messaging().subscribe(toTopic: "matchResults") { error in
				
				if let error = error {
					print("Failed to subscribe to match results topic")
				} else {
					print("Subscribed to matches topic")
				}
			}
		}
	}
	
}

extension AppDelegate: MessagingDelegate{
	
	func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
		print("Firebase registration token: \(fcmToken)")
		
		let dataDict:[String: String] = ["token": fcmToken]
		NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
		// TODO: If necessary send token to application server.
		// Note: This callback is fired at each app startup and whenever a new token is generated.
		let defaults = UserDefaults.standard
		defaults.set(fcmToken, forKey: "fcmToken")
	}
	
	func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
		print("Received data message: \(remoteMessage.appData)")
	}
}
