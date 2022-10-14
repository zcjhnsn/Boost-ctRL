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
            // MARK: - Home Page
    
            NewsView()
            .tabItem {
                Label {
                    Text("Home")
                } icon: {
                    Image("ctrl")
                        .imageScale(.large)
                }
            }
            
            // MARK: - Events

            EventListScreen()
            .tabItem {
                Image(systemName: "calendar")
                Text("Events")
            }
            
            // MARK: - Teams

            TeamFilterView()
            .tabItem {
                Image(systemName: "person.3")
                Text("Teams")
            }
            
            // MARK: - Players

            SearchScreen()
                .background(Color.secondaryGroupedBackground)
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
