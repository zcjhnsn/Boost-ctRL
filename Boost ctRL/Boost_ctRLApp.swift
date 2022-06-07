//
//  Boost_ctRLApp.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/13/21.
//

import SwiftUI

// swiftlint:disable type_name
@main
struct Boost_ctRLApp: App {
    @StateObject var iconNames = IconNames()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(iconNames)
        }
    }
}
