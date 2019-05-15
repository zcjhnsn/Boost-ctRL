//
//  Extensions.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/11/19.
//  Copyright © 2019 Zac Johnson. All rights reserved.
//

import UIKit

// MARK: - UIColor Extension

// Create UIColor from hexcode
extension UIColor {
	convenience init?(hex: String) {var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
		hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
		
		var rgb: UInt32 = 0
		
		var r: CGFloat = 0.0
		var g: CGFloat = 0.0
		var b: CGFloat = 0.0
		let a: CGFloat = 1.0
		
		guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }
		
		r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
		g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
		b = CGFloat(rgb & 0x0000FF) / 255.0
		
		self.init(red: r, green: g, blue: b, alpha: a)
	}
	
	// Store theme colors
	struct ctRLTheme {
		static var midnightBlue = UIColor(hex: "283149")!
		static var darkBlue = UIColor(hex: "404b69")!
		static var hotPink = UIColor(hex: "f73859")!
		static var cloudWhite = UIColor(hex: "dbedf3")!
	}
}

//////////////////////////////////////////////

// MARK: - UIImageView Extension

// For image caching the logos

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
	func loadImageFromCacheWithUrlString(urlString: String) {
		
		self.image = UIImage(named: "logo-null")
		
		// Check cache for cached image first
		if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
			self.image = cachedImage
			return
		}
		
		// Otherwise, download image
		let url = URL(string: urlString)
		print(url!)
		URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
			if error != nil {
				print(error!)
				self.image = UIImage(named: "logo-null")
				return
			}
			
			DispatchQueue.main.async {
				if let downloadedImage = UIImage(data: data!) {
					imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
					
					self.image = downloadedImage
				}
			}
			
		}).resume()
	}
}

//////////////////////////////////////////////

// MARK: - String Extension

// Convert match date/time from mountain to date/time for user
extension String {
	func mountainToLocal() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
		dateFormatter.timeZone = TimeZone(identifier: "America/Denver")
		
		let dt = dateFormatter.date(from: self)
		dateFormatter.timeZone = TimeZone.current
		dateFormatter.dateFormat = "d MMM yyyy-HH:mm zzz"
		
		return dateFormatter.string(from: dt ?? Date())
	}
}

//////////////////////////////////////////////

// MARK: - AppDelegate Extension

// download data from firebase on load
extension AppDelegate {
	func downloadDataFromFirebase() {
		let downloader = Downloader()
		if downloader.loadTeamsAndStandings() {
			print("Initial Team Download Complete: ✅")
		} else {
			print("Returned False ‼️")
		}
		
		if downloader.loadMatches() {
			print("Initial Matches Download ✅")
		} else {
			print("Initial Matches Download 🔴")
		}
	}
}

//////////////////////////////////////////////

// MARK: - Bundle Extension

extension Bundle {
	var releaseVersionNumber: String? {
		return infoDictionary?["CFBundleShortVersionString"] as? String
	}
	var buildVersionNumber: String? {
		return infoDictionary?["CFBundleVersion"] as? String
	}
	var releaseVersionNumberPretty: String {
		return "\(releaseVersionNumber ?? "1.0.0")"
	}
}

