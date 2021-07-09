//
//  SettingsView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/13/21.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var isShowingChangeLog: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Other Resources")) {
                    Link("RL Esports Subreddit", destination: URL(string: "https://reddit.com/r/rocketleagueesports")!)
                    Link("Liquipedia", destination: URL(string: "https://liquipedia.net/rocketleague/Main_Page")!)
                    Link("Octane.gg", destination: URL(string: "https://octane.gg")!)
                    Link("Rocketeers.gg", destination: URL(string: "https://rocketeers.gg")!)
                }
                
                Section(header: Text("Connect with Boost ctRL")) {
                    Link("@BoostctRL on Twitter", destination: URL(string: "https://twitter.com/boostctrl")!)
                    NavigationLink("Tip the Dev", destination: TipJarView())
                }
                
                Section(header: Text("App Info")) {
                    NavigationLink("Change Log", destination: ChangeLogView()
                                    .navigationBarTitle("Change Log")
                                    .navigationBarItems(trailing: Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }, label: {
                                        Image(systemName: "xmark")
                                            .foregroundColor(.primary)
                                    }))
                    )
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(Bundle.main.releaseVersionNumberPretty)
                    }
                }
            }
            .navigationBarTitle(Text("Settings"))
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.primary)
            }))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
