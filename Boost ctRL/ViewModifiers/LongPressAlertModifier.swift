//
//  LongPressAlertModifier.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/30/21.
//

import SwiftUI


/// https://stackoverflow.com/questions/63181915/how-to-create-an-extension-on-a-view-to-show-alerts-on-long-press-gesture-swif
struct LongPressAlertModifier: ViewModifier {
    @State var showAlert = false
    let title: String
    let message: String
    let dismissButton: Alert.Button

    func body(content: Content) -> some View {
        content
            .onLongPressGesture {
                self.showAlert = true
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(title), message: Text(message), dismissButton: dismissButton)
            }
    }
}
