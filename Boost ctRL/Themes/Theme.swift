//
//  Theme.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 8/5/21.
//

import UIKit

protocol Theme {
    var primaryBackgroundColor: UIColor { get }
    var secondaryBackgroundColor: UIColor { get }
    var labelColor: UIColor { get }
    var secondaryLabelColor: UIColor { get }
    var accentColor: UIColor { get }
    var themeName: String { get }
}

enum ThemeManager {
    static let themes: [Theme] = []
    
    static func getTheme(_ theme: Int) -> Theme {
        Self.themes[theme]
    }
}
