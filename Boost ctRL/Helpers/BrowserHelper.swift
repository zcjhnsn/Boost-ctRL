//
//  BrowserHelper.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/19/21.
//

import SwiftUI

extension String {
    func browserURL(for scheme: String) -> String {
        if self.contains("https://") {
            return self.replacingOccurrences(of: "https://", with: scheme)
        } else if self.contains("http://") {
            return self.replacingOccurrences(of: "http://", with: scheme)
        } else {
            return "\(scheme)\(self)"
        }
    }
}

struct LinkHelper {
    
    static func processLinkForDestination(_ link: String, destination: Int, fallbackURL: String? = nil) -> URL {
        var urlString = ""
        var fallback = "https://octane.gg"
        if let fb = fallbackURL {
            fallback = fb
        }
        
        switch destination {
        case 2: // Chrome
            urlString = link.browserURL(for: Browsers.chrome.scheme)
            fallback = fallback.browserURL(for: Browsers.chrome.scheme)
        case 3: // Duck
            urlString = link.browserURL(for: Browsers.duckduckgo.scheme)
            fallback = fallback.browserURL(for: Browsers.duckduckgo.scheme)
        case 4: // Firefox
            urlString = link.browserURL(for: Browsers.firefox.scheme)
            fallback = fallback.browserURL(for: Browsers.firefox.scheme)
        case 5: // Safari
            urlString = link.browserURL(for: Browsers.safari.scheme)
            fallback = fallback.browserURL(for: Browsers.safari.scheme)
        default:
            urlString = link
        }
        
        return URL(string: urlString) ?? URL(string: fallback)!
    }
}
