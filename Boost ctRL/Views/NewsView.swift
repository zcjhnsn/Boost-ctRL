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
                        
                        
//                        Text("Top Stories")
//                            .font(.system(.title2, design: .default).weight(.bold))
//                            .padding(.leading, 15)
//                            .padding(.top, 5)
//                            .unredacted()
                        
                        Spacer()
                    }
                    ArticleColumnView(articles: articlesViewModel.octaneArticles)
                        .redacted(when: articlesViewModel.isOctaneLoading)
                        .animation(.easeInOut)
                }
                
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Home")
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

extension View {
    @ViewBuilder
    func redacted(when condition: Bool) -> some View {
        if !condition {
            unredacted()
        } else {
            redacted(reason: .placeholder)
                .shimmering()
        }
    }
}
