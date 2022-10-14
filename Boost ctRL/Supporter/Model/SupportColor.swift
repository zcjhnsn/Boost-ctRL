//
//  SupportColor.swift
//  Supporter
//
//  Created by Jordi Bruin on 05/12/2021.
//

import Foundation
import SwiftUI

// Used to pass colors from JSON to SwiftUI. You can customize the colors used here to match your project
enum SupportColor: Int, Codable {
    
    case primary = 0
    case secondary = 1
    case tertiary = 2
    case ctrlBlue = 3
    case ctrlOrange = 4
        
    var color: Color {
        switch self {
        case .primary:
            return .blue
        case .secondary:
            return .red
        case .tertiary:
            return .green
        case .ctrlBlue:
            return .ctrlBlue
        case .ctrlOrange:
            return .ctrlOrange
        }
    }
    
    init(colorIndex: Int) {
        if let color = SupportColor(rawValue: colorIndex) {
            self = color
        } else {
            self = .primary
        }
    }
}
