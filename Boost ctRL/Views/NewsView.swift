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
    
    var body: some View {
        NavigationView {
            ScrollView {
                Group {
                    ArticleRowView(publisherName: NewsSource.rocketeers.rawValue, articles: articlesViewModel.rocketeersArticles)
                        .listRowInsets(EdgeInsets())
                        .animation(.linear(duration: 0.3))
                        .overlay(ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .opacity(articlesViewModel.isRocketeersLoading ? 1 : 0)
                        )
                    
                    Divider()
                }
                
                
                Group {
                    
                    ArticleRowView(publisherName: NewsSource.octane.rawValue, articles: articlesViewModel.octaneArticles)
                        .listRowInsets(EdgeInsets())
                        .animation(.linear(duration: 0.3))
                        .overlay(ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .opacity(articlesViewModel.isOctaneLoading ? 1 : 0)
                        )
                    
                    Divider()
                }
                    
                
            }
            .listStyle(PlainListStyle())
            .navigationTitle("News")
            .navigationBarItems(trailing: Button(action: {
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
