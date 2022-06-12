//
//  File.swift
//  
//
//  Created by Kevin Klaebe on 26.09.21.
//

import Foundation
import CoreGraphics
import SwiftUI

extension CGPoint {
    init(angle: SwiftUI.Angle, hypothenuse: CGFloat) {
        self.init(
            x: cos(angle.radians) * hypothenuse,
            y: sin(angle.radians) * hypothenuse
        )
    }
}
