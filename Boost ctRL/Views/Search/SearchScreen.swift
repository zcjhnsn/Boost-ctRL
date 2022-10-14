//
//  SearchScreen.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 6/6/22.
//

import SwiftUI

struct SearchScreen: View {
    @State private var showSupport: Bool = false
    @StateObject private var viewModel = SearchViewModel()
    
    let suggestions: [String] = [
        "GarrettG",
        "RLCS 2021-22 World Championship",
        "Moist Esports",
        "RLCS Season 5 World Championship"
    ]
    
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
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("ctrl-color")
                        .resizable()
                        .frame(width: 30, height: 28, alignment: .center)
                        .padding(.trailing)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSupport.toggle()
                    } label: {
                        Image(systemName: "questionmark.circle")
                    }

                }
            })
        }
        .fullScreenCover(isPresented: $showSupport) {
            SupportScreen()
        }
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
