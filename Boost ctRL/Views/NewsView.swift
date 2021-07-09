//
//  NewsView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/13/21.
//

import SwiftUI

struct NewsView: View {
    @State var isShowingSettings: Bool = false
    @ObservedObject var articlesViewModel = ArticlesViewModel()
    @ObservedObject var recentMatchesViewModel = RecentMatchesViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                Group {
                    RecentResultsRowView(recentMatches: recentMatchesViewModel.matches)
                        .listRowInsets(EdgeInsets())
                        .redacted(reason: recentMatchesViewModel.isMatchesLoading ? .placeholder : [])
                        .animation(.linear(duration: 0.3))
                    
                    Divider()
                        .opacity(recentMatchesViewModel.matches.isEmpty ? 0.0 : 1.0)
                        
                }
                    
                Group {
                    ArticleColumnView(publisherName: "Top Stories", articles: articlesViewModel.octaneArticles)
                        .redacted(reason: articlesViewModel.isOctaneLoading ? .placeholder : [])
                }
                
            }
            .listStyle(PlainListStyle())
            .navigationTitle("News")
            .navigationBarItems(leading: Label(
                title: { Text("Boost Control").font(.system(.headline, design: .default).weight(.bold)).foregroundColor(.blue) },
                icon: { Image("ctrl-blue").resizable().frame(width: 25, height: 25, alignment: .center) }
),trailing: Button(action: {
                isShowingSettings = true
            }, label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(.primary)
            }))
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

/*
                Group {
                    ArticleRowView(publisherName: NewsSource.rocketeers.rawValue, articles: articlesViewModel.rocketeersArticles)
                        .listRowInsets(EdgeInsets())
                        .animation(.linear(duration: 0.3))
                        .redacted(reason: articlesViewModel.isRocketeersLoading ? .placeholder : [])

                    Divider()
                }
                
                
                Group {

                    ArticleRowView(publisherName: NewsSource.octane.rawValue, articles: articlesViewModel.octaneArticles)
                        .listRowInsets(EdgeInsets())
                        .animation(.linear(duration: 0.3))
                        .redacted(reason: articlesViewModel.isOctaneLoading ? .placeholder : [])

                    Divider()
                }
*/
