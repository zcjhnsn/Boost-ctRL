//
//  NotificationHandler.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 10/3/19.
//  Copyright © 2019 Zac Johnson. All rights reserved.
//

import Foundation
import Firebase
import FirebaseMessaging
import UserNotifications

class NotificationManager: NSObject {
	let gcmMessageIDKey = "gcm.message_id"
	
	override init() {
		super.init()
		Messaging.messaging().delegate = self
		UNUserNotificationCenter.current().delegate = self
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
			guard settings.authorizationStatus == .authorized else { return }
			
			DispatchQueue.main.async {
				UIApplication.shared.registerForRemoteNotifications()
			}
			
			Messaging.messaging().subscribe(toTopic: "news") { error in
				
				if let error = error {
					print("Failed to subscribe to news topic: \(error)")
				} else {
					print("Subscribed to news topic")
				}
				
			}
			
			Messaging.messaging().subscribe(toTopic: "matchResults") { error in
				
				if let error = error {
					print("Failed to subscribe to match results topic: \(error)")
				} else {
					print("Subscribed to matches topic")
				}
			}
		}
	}
}

extension NotificationManager: UNUserNotificationCenterDelegate {
	
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
}

extension NotificationManager: MessagingDelegate {
	
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
