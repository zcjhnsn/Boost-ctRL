//
//  SettingsView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/13/21.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var iconSettings: IconNames
    @State private var selectedIconIndex: Int = 0
    
    @AppStorage("LinkDestination") var linkDestination = 0
    
    @State var isShowingChangeLog: Bool = false
    
    let twitterURL = "https://twitter.com/boostctrl"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Customization")) {
//                    Picker(selection: $iconSettings.currentIndex, label: Text("App Icon")) {
//                        ForEach(0 ..< iconSettings.iconNames.count) { i in
//                            HStack(spacing: 20) {
//                                Image(uiImage: UIImage(named: self.iconSettings.iconNames[i] ?? "AppIcon") ?? UIImage())
//                                    .resizable()
//                                    .renderingMode(.original)
//                                    .frame(width: 50, height: 50, alignment: .leading)
//                                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
//                                Text(self.iconSettings.iconNames[i]?.components(separatedBy: "60x60").first ?? "Default")
//                            }
//                        }.onReceive([self.iconSettings.currentIndex].publisher.first()) { value in
//                            let i = self.iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
//                            if value != i {
//                                UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value], completionHandler: { error in
//                                    if let error = error {
//                                        print(error.localizedDescription)
//                                    } else {
//                                        print("Success!")
//                                    }
//                                })
//                            }
//                        }
//                    }
                    
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


struct IconSelectionView: View {
    var items: [String?]
    @Binding var selectedItem: Int
    
    var body: some View {
        Form {
            ForEach(0 ..< items.count, id: \.self) { index in
                HStack {
                    Image(uiImage: UIImage(named: self.items[index] ?? "AppIcon") ?? UIImage())
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 50, height: 50, alignment: .leading)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    Text(self.items[index] ?? "Default")
                    Spacer()
                    if self.selectedItem == index {
                        Image(systemName: "checkmark").foregroundColor(Color.blue)
                    }
                }
                .onTapGesture {
                    self.selectedItem = index
                }
            }
        }
    }
}
