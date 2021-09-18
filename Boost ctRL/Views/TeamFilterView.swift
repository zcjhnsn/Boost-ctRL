//
//  TeamFilterView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 9/16/21.
//

import SwiftUI
import BottomSheet

struct TeamFilterView: View {
    @ObservedObject var activeTeamsViewModel = ActiveTeamsViewModel()
    @State var selectedRegion: Int = 0
    @State var isShowingFAQ: Bool = false
    @State var isShowingClear: Bool = false
    @State var isSearching: Bool = false
    
    let backgroundColors: [Color] = [Color(red: 0.2, green: 0.85, blue: 0.7), Color(red: 0.13, green: 0.55, blue: 0.45)]
    
    var body: some View {
        NavigationView {
            ScrollView {
                HStack {
                    HStack {
                        TextField("Search Teams by Name", text: $activeTeamsViewModel.searchText)
                            .onChange(of: activeTeamsViewModel.searchText, perform: { value in
                                if value.isEmpty {
                                    isShowingClear = false
                                } else {
                                    isShowingClear = true
                                    isSearching = true
                                }
                            })
                            .padding(.leading, 24)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(6)
                    .padding(.horizontal)
                    .onTapGesture(perform: {
                        isSearching = true
                    })
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Spacer()
                            
                            if isShowingClear {
                                Button(action: {
                                    activeTeamsViewModel.searchText = ""
                                }, label: {
                                    Image(systemName: "xmark.circle.fill")
                                })
                            }
                        }
                        .foregroundColor(.gray)
                        .padding(.horizontal, 24)
                    )
                    .transition(.move(edge: .trailing))
                    .animation(.easeInOut)
                    
                    if isSearching {
                        Button(action: {
                            hideKeyboard()
                            isSearching = false
                        }, label: {
                            Text("Cancel")
                                .padding(.trailing)
                                .padding(.leading, -12)
                        })
                        .transition(.move(edge: .trailing))
                        .animation(.easeInOut)
                    }
                }
                
                Picker("Region", selection: $selectedRegion) {
                    ForEach(0 ..< Region.allCases.count) {
                        Text(Region.allCases[$0].rawValue.uppercased())
                    }
                }.pickerStyle(SegmentedPickerStyle())
                .padding()
                    
                ForEach(activeTeamsViewModel.filteredData.filter {
                    if selectedRegion != 0 {
                        return $0.team.region?.rawValue == Region.allCases[selectedRegion].rawValue
                    }
                    return true
                }, id: \.team.id) {
                    TeamBasicView(team: $0)
                        .onTapGesture(perform: {
                            if isSearching {
                                resignSearchResponder()
                            }
                        })
                        .padding([.bottom], 1)
                    
                    Divider()
                }
                
                Spacer()
                
            }
            .onTapGesture(perform: {
                resignSearchResponder()
            })
            .navigationBarTitle("Teams")
            .navigationBarItems(leading: Label(
                title: { Text("Boost Control").font(.system(.headline, design: .default).weight(.bold)).foregroundColor(.blue) },
                icon: { Image("ctrl-blue").resizable().frame(width: 25, height: 25, alignment: .center) }
            ),trailing: Button(action: {
                isShowingFAQ = true
            }, label: {
                Image(systemName: "questionmark.circle")
                    .foregroundColor(.primary)
            }))
        }
        
    
        .onAppear(perform: {
            activeTeamsViewModel.getTeams()
        })
    }
    
    func resignSearchResponder() {
        hideKeyboard()
        isSearching = false
    }
}



struct TeamFilterView_Previews: PreviewProvider {
    static var previews: some View {
        TeamFilterView()
    }
}




struct MultiSelectPickerView: View {
    //the list of all items to read from
    @State var sourceItems: [String]
    
    //a binding to the values we want to track
    @Binding var selectedItems: [String]
    
    var body: some View {
        Form {
            List {
                ForEach(sourceItems, id: \.self) { item in
                    Button(action: {
                        withAnimation {
                            if self.selectedItems.contains(item) {
                                //you may need to adapt this piece, my object has an ID I match against rather than just the string
                                self.selectedItems.removeAll(where: { $0 == item })
                            } else {
                                self.selectedItems.append(item)
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "checkmark")
                                .opacity(self.selectedItems.contains(item) ? 1.0 : 0.0)
                            Text("\(item)")
                        }
                    }
                    .foregroundColor(.primary)
                }
            }
        }
        .listStyle(GroupedListStyle())
    }
}

class TeamFilter: ObservableObject {
    @Published var selectedRegions: [String] = []
}
