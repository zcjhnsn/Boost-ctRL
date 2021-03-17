//
//  ContentView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/13/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NewsView()
            .tabItem {
                Image(systemName: "newspaper")
                Text("News")
            }
            
            NavigationView {
                Text("Page Two")
                    .navigationBarTitle("Page Two")
            }
            .tabItem {
                Image(systemName: "calendar")
                Text("Matches")
            }
            
            NavigationView {
                Text("Page Three")
                    .navigationBarTitle("Page Three")
            }
            .tabItem {
                Image(systemName: "3.circle")
                Text("Page 3")
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
