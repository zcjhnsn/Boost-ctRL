//
//  NewsView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/13/21.
//

import SwiftUI
import Shimmer

struct NewsView: View {
    @State private var isShowingSettings: Bool = false
    @State private var showSupport: Bool = false
    @StateObject var articlesViewModel = ArticlesViewModel()
    @StateObject var recentMatchesViewModel = RecentMatchesViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                SwiftUI.Group {
                    RecentResultsRowView(recentMatches: recentMatchesViewModel.isMatchesLoading ? recentMatchesViewModel.dummyData : recentMatchesViewModel.matches)
                        .listRowInsets(EdgeInsets())
                        .animation(.easeInOut, value: recentMatchesViewModel.isMatchesLoading)
                        .redacted(when: recentMatchesViewModel.isMatchesLoading)                        
                    
                    Divider()
                        .opacity(recentMatchesViewModel.matches.isEmpty ? 0.0 : 1.0)
                    
                }
                
                SwiftUI.Group {
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
                    ArticleColumnView(viewModel: articlesViewModel)
                }
                
            }
            .background(Color.primaryGroupedBackground)
            .listStyle(PlainListStyle())
            .navigationTitle("Boost Control")
            .toolbar(content: {
                
                // MARK: Left NavBar Item

                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Image("ctrl-color")
                        .resizable()
                        .frame(width: 30, height: 28, alignment: .center)
                        .padding(.trailing)
                }
                
                // MARK: Right NavBar Item
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSupport.toggle()
                    }, label: {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(.primary)
                    })
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingSettings = true
                    }, label: {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.primary)
                    })
                }
            })
            .fullScreenCover(isPresented: $showSupport) {
                SupportScreen()
            }
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
            .preferredColorScheme(.light)
        NewsView()
            .preferredColorScheme(.dark)
    }
}
