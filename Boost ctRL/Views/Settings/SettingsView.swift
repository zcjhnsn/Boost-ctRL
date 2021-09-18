//
//  SettingsView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/13/21.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("LinkDestination") var linkDestination = 0
    
    @State var isShowingChangeLog: Bool = false
    
    let twitterURL = "https://twitter.com/boostctrl"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Customization")) {
                    Picker("Open links in", selection: $linkDestination) {
                        Text("In-App (Safari)").tag(0)
                        
                        Text("System Default").tag(1)
                        
                        if UIApplication.shared.canOpenURL(URL(string: Browsers.chrome.scheme)!) {
                            Text("Chrome").tag(2)
                        } else {
                            Text("Chrome").foregroundColor(.secondary)
                        }
                        
                        if UIApplication.shared.canOpenURL(URL(string: Browsers.duckduckgo.scheme)!) {
                            Text("DuckDuckGo").tag(3)
                        } else {
                            Text("DuckDuckGo").foregroundColor(.secondary)
                        }
                        
                        if UIApplication.shared.canOpenURL(URL(string: Browsers.firefox.scheme)!) {
                            Text("Firefox").tag(4)
                        } else {
                            Text("Firefox").foregroundColor(.secondary)
                        }
                        
                        if UIApplication.shared.canOpenURL(URL(string: Browsers.safari.scheme)!) {
                            Text("Safari").tag(5)
                        } else {
                            Text("Safari").foregroundColor(.secondary)
                        }
                    }
                }
                
                Section(header: Text("Other Resources")) {
                    Link("RL Esports Subreddit", destination: LinkHelper.processLinkForDestination("https://reddit.com/r/rocketleagueesports", destination: linkDestination, fallbackURL: twitterURL))
                    Link("Liquipedia", destination: LinkHelper.processLinkForDestination("https://liquipedia.net/rocketleague/Main_Page", destination: linkDestination, fallbackURL: twitterURL))
                    Link("Octane.gg", destination: LinkHelper.processLinkForDestination("https://octane.gg", destination: linkDestination, fallbackURL: twitterURL))
                    Link("Rocketeers.gg", destination: LinkHelper.processLinkForDestination("https://rocketeers..", destination: linkDestination, fallbackURL: twitterURL))
                }
                
                Section(header: Text("Connect with Boost ctRL")) {
                    
                    Link("@BoostctRL on Twitter", destination: LinkHelper.processLinkForDestination(twitterURL, destination: linkDestination))
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
