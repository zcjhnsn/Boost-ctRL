//
//  NewsView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/13/21.
//

import SwiftUI
import Shimmer

struct NewsView: View {
    @State var isShowingSettings: Bool = false
    @ObservedObject var articlesViewModel = ArticlesViewModel()
    @ObservedObject var recentMatchesViewModel = RecentMatchesViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                Group {
                    RecentResultsRowView(recentMatches: recentMatchesViewModel.isMatchesLoading ? recentMatchesViewModel.dummyData : recentMatchesViewModel.matches)
                        .listRowInsets(EdgeInsets())
                        .animation(.easeInOut)
                        .redacted(when: recentMatchesViewModel.isMatchesLoading)                        
                    
                    Divider()
                        .opacity(recentMatchesViewModel.matches.isEmpty ? 0.0 : 1.0)
                    
                }
                
                Group {
                    HStack {
                        Label(
                            title: {
                                Text("Top Stories")
                                    .font(.system(.title3, design: .default).weight(.bold))
                            },
                            icon: {
                                Image(systemName: "newspaper")
                                    .foregroundColor(.blue)
                            }
                        )
                            .padding(.leading, 15)
                            .padding(.top, 5)
                        
                        Spacer()
                    }
                    ArticleColumnView(articles: articlesViewModel.octaneArticles)
                        .redacted(when: articlesViewModel.isOctaneLoading)
                        .animation(.easeInOut)
                }
                
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Home")
            .toolbar(content: {
                
                // MARK: Left NavBar Item

                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Image("ctrl-color").resizable().frame(width: 25, height: 25, alignment: .center)
                    Text("Boost \(Text("Control").foregroundColor(.ctrlOrange))")
                        .foregroundColor(.ctrlBlue)
                        .font(.system(.title3, design: .default).weight(.bold))
                    
                }
                
                // MARK: Right NavBar Item
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingSettings = true
                    }, label: {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.primary)
                    })
                }
            })
            .sheet(isPresented: $isShowingSettings, content: {
                SettingsView()
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}