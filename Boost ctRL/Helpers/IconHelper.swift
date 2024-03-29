//
//  IconHelper.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 9/27/21.
//

import SwiftUI

class IconNames: ObservableObject {
    var iconNames: [String?] = [nil]
    // exact index we're at inside our icon names
    @Published var currentIndex = 0
    
    init() {
        getAlternateIconNames()
        
        if let currentIcon = UIApplication.shared.alternateIconName {
            self.currentIndex = iconNames.firstIndex(of: currentIcon) ?? 0
        }
    }
    
    func getAlternateIconNames() {
        // looking into our info.plist file to locate the specific Bundle with our icons
        if let icons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any],
           let alternateIcons = icons["CFBundleAlternateIcons"] as? [String: Any] {
            
            for (_, value) in alternateIcons {
                // Accessing the name of icon list inside the dictionary
                guard let iconList = value as? [String: Any] else { return }
                
                // Accessing the name of icon files
                guard let iconFileName = iconList["CFBundleIconName"] as? String
                else { return }
                
                iconNames.append(iconFileName)
            }
            
            iconNames = iconNames.sorted(by: {
                if $0 == nil {
                    return true
                } else if $1 == nil {
                    return false
                } else {
                    return $0!.lowercased() < $1!.lowercased()
                }
            })
        }
    }
}
