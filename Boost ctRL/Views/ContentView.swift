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
                Image(systemName: "flame")
                Text("Home")
            }
            
            // MARK: - Events

            NavigationView {
                Text("Page Two")
                    .navigationBarTitle("Events")
            }
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

            NavigationView {
                Text("Players")
                    .navigationBarTitle("Players")
            }
            .tabItem {
                Image(systemName: "gamecontroller")
                Text("Players")
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
