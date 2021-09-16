//
//  LazyNavigationView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/30/21.
//

import SwiftUI


/// `NavigationLink`s initialize their destination `View`s before actually attempting to navigate to them.
/// This creates circumstances where `View`s that are never actually navigated to are fully initialized.
/// A common convention in SwiftUI is to handle ViewModel initialization in the `init()` method of a `View`.
/// This becomes especially problematic when the ViewModel is populated via a Data Service or Manager.
/// If one of these `View`s with ViewModel initialization and network requests is used in a `NavigationLink`,
/// we could potentially be wasting resources. The wrapper delays the initialization of the destination `View`
///  until SwiftUI needs to use the body of the `NavigationLazyView` (which does not occur until an actual navigation attempt).
///
/// See: https://willowtreeapps.com/ideas/an-introduction-to-swiftui
struct NavigationLazyView<Content: View>: View {
   let build: () -> Content

   init(_ build: @autoclosure @escaping () -> Content) {
       self.build = build
   }

   var body: Content {
       build()
   }
}
