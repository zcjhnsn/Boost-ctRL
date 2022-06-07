//
//  Color+Ext.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 9/29/21.
//

import SwiftUI

extension Color {
    public static var ctrlBlue: Color {
        return Color(red: 46/255.0, green: 151/255.0, blue: 182/255.0)
    }
    
    public static var ctrlOrange: Color {
        return Color(red: 236/255.0, green: 97/255.0, blue: 56/255.0)
    }
    
    public static var primarySystemBackground: Color {
        return Color(uiColor: UIColor.systemBackground)
    }
    
    public static var secondarySystemBackground: Color {
        return Color(uiColor: UIColor.secondarySystemBackground)
    }
    
    public static var tertiarySystemBackground: Color {
        return Color(uiColor: UIColor.tertiarySystemBackground)
    }
    
    public static var primaryGroupedBackground: Color {
        return Color(uiColor: UIColor.systemGroupedBackground)
    }
    
    public static var secondaryGroupedBackground: Color {
        return Color(uiColor: UIColor.secondarySystemGroupedBackground)
    }
    
    public static var tertiaryGroupedBackground: Color {
        return Color(uiColor: UIColor.tertiarySystemGroupedBackground)
    }
    
    public static var secondaryLabel: Color {
        return Color(uiColor: UIColor.secondarySystemFill)
    }
}
