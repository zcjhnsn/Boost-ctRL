//
//  SearchScreen.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 6/6/22.
//

import SwiftUI

struct SearchScreen: View {
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.primaryGroupedBackground
                
                ScrollView {
                    
                    if viewModel.searchText.count >= 3 {
                        ForEach(viewModel.filteredSearchItems, id: \.id) { item in
                            SearchItemView(item: item)
                                .padding(.horizontal)
                        }
                    }
                    
                    Spacer()
                }
            }
            .background(Color.primaryGroupedBackground)
            .navigationTitle(Text("Search"))
            .navigationBarTitleDisplayMode(.large)
            
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Image("ctrl-color")
                    .resizable()
                    .frame(width: 30, height: 28, alignment: .center)
                    .padding(.trailing)
            }
        })
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search teams, events, and players")
        
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
            .preferredColorScheme(.light)
        SearchScreen()
            .preferredColorScheme(.dark)
    }
}
