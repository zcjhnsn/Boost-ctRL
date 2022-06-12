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
                Picker("Region", selection: $selectedRegion) {
                    ForEach(0 ..< Region.allCases.count, id: \.self) {
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
                        .redacted(when: activeTeamsViewModel.isTeamsLoading)
                        .onTapGesture(perform: {
                            if isSearching {
                                resignSearchResponder()
                            }
                        })
                        .padding([.vertical], 4)
                        .background(Color.secondaryGroupedBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .padding([.bottom], 1)
                        
                    
                }
                .padding(.horizontal)
                
                VStack(alignment: .center) {
                    Text("Can't find a team? Looking for a player?\nTap \(Image(systemName: "magnifyingglass")) and search there.")
                        .font(.subheadline)
                        .foregroundColor(Color(uiColor: UIColor.tertiaryLabel))
                        .multilineTextAlignment(.center)
                }
                .padding()
                .padding(.horizontal)
                
                Spacer()
                
            }
            .background(Color.primaryGroupedBackground)
            .navigationBarTitle("Teams")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("ctrl-color")
                        .resizable()
                        .frame(width: 30, height: 28, alignment: .center)
                        .padding(.trailing)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // Present FAQ
                    } label: {
                        Image(systemName: "questionmark.circle")
                    }

                }
            })
            .alert(isPresented: $isShowingFAQ, content: {
                Alert(title: Text("This page only shows ACTIVE teams"), message: Text("Use the Events tab to find older or less relevant teams."), dismissButton: .default(Text("Okay")))
            })
        }
        .searchable(text: $activeTeamsViewModel.searchText, prompt: "Search teams by name")
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
    // the list of all items to read from
    @State var sourceItems: [String]
    
    // a binding to the values we want to track
    @Binding var selectedItems: [String]
    
    var body: some View {
        Form {
            List {
                ForEach(sourceItems, id: \.self) { item in
                    Button(action: {
                        withAnimation {
                            if self.selectedItems.contains(item) {
                                // you may need to adapt this piece, my object has an ID I match against rather than just the string
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
