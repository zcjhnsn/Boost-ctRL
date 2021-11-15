//
//  View+Ext.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/22/21.
//

import SwiftUI
import Shimmer

extension View {
    
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
    
    
    /// Display a customizable alert on long press of a view
    /// See: https://stackoverflow.com/questions/63181915/how-to-create-an-extension-on-a-view-to-show-alerts-on-long-press-gesture-swif
    /// - Parameters:
    ///   - title: Alert title
    ///   - message: Alert message
    ///   - dismissButton: Style for dismiss button
    /// - Returns: long press alert modifier
    func longPressAlert(title: String, message: String, dismissButton: Alert.Button) -> some View {
        self.modifier(LongPressAlertModifier(title: title, message: message, dismissButton: dismissButton))
    }
    
    
    #if canImport(UIKit)
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    #endif
    
    
    /// Redact and add a shimmer to view
    /// - Parameter condition: Usually an isLoading flag
    /// - Returns: View
    @ViewBuilder func redacted(when condition: Bool) -> some View {
        if !condition {
            unredacted()
        } else {
            redacted(reason: .placeholder)
                .shimmering()
        }
    }
    
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

extension Image {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
