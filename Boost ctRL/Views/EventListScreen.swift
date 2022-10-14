//
//  EventListScreen.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 1/28/22.
//

import SwiftUI

enum EventListStatus: String, CaseIterable {
    case current = "Current"
    case completed = "Completed"
}

struct EventListScreen: View {
    @State private var showSupport: Bool = false
    @StateObject private var eventListViewModel = EventListViewModel()
    @State private var eventStatus: EventListStatus = .current
    
    var body: some View {
        NavigationView {
            VStack {
                if !eventListViewModel.eventsFuture.isEmpty {
                    EventListView(selectedType: $eventStatus, eventsListViewModel: eventListViewModel)
                        .animation(.easeInOut, value: eventStatus)
                }
            }
            .navigationTitle(Text("Events"))
            .background(Color.primaryGroupedBackground)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker("Select event status", selection: self.$eventStatus.animation()) {
                        ForEach(EventListStatus.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Image("ctrl-color")
                        .resizable()
                        .frame(width: 30, height: 28, alignment: .center)
                        .padding(.trailing)
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        showSupport.toggle()
                    } label: {
                        Image(systemName: "questionmark.circle")
                    }

                }
                
                    
            }
        }
        .fullScreenCover(isPresented: $showSupport) {
            SupportScreen()
        }
        .searchable(text: $eventListViewModel.searchText, placement: .navigationBarDrawer, prompt: "Search for an event")
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("Select Stats for Team or Players", selection: self.$eventStatus.animation()) {
                    ForEach(EventListStatus.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding([.horizontal])
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct EventListView: View {
    @Binding var selectedType: EventListStatus
    @ObservedObject var eventsListViewModel: EventListViewModel
    
    var body: some View {
        switch selectedType {
        case .current:
            EventListSelectedView(events: eventsListViewModel.filteredFuture)
                .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
        case .completed:
            EventListSelectedView(events: eventsListViewModel.filteredCompleted)
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
        }
    }
}

struct EventListSelectedView: View {
    var events: [Event]
    @State var selectedEvent: Event?
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(events, id: \.slug) { event in
                EventCardView(event: event)
            }
            
            Text("Can't find an event? Tap \(Image(systemName: "magnifyingglass")) and search there.")
                .font(.subheadline)
                .foregroundColor(Color(uiColor: UIColor.tertiaryLabel))
                .padding()
            
            Spacer()
        }
        .padding([.horizontal])
    }
}

struct EventListScreen_Previews: PreviewProvider {
    static var previews: some View {
        EventListScreen()
    }
}
