//
//  TeamScreen.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 6/7/22.
//

import SwiftUI

struct TeamScreen: View {
    @StateObject var viewModel = TeamViewModel()
    
    @State var showPlayerScreen = false
    @State var selectedPlayer = ExampleData.player
    
    var team: Team
    var name: String = ""
    var image: String = ""
    var region: String = ""
    
    var body: some View {
        
        ZStack {
            Color.primaryGroupedBackground
            
            ScrollView(.vertical, showsIndicators: false) {
                TeamHeaderView(team: team)
                
                VStack(spacing: 0) {
                    HStack {
                        Label(
                            title: {
                                Text("Roster")
                                    .font(.system(.title3, design: .default).weight(.bold))
                                
                            },
                            icon: {
                                Image(systemName: "person.3.fill")
                                    .foregroundColor(.ctrlBlue)
                            }
                        )
                        
                        Spacer()
                    }
                    .padding([.horizontal])
                    .padding(.vertical, 2)
                    
                    NavigationLink("Player Info", isActive: $showPlayerScreen) {
                        PlayerScreen(playerID: selectedPlayer.slug)
                    }
                    .hidden()
                    
                    VStack {
                        ForEach(viewModel.players, id: \.listID) { playerRow in
                            HStack {
                                Text(IsoCountries.flag(countryCode: playerRow.country) ?? "🌎")
                                
                                Text(playerRow.tag)
                                
                                if playerRow.substitute {
                                    Text("S")
                                        .foregroundColor(Color.gray)
                                }
                                
                                if playerRow.coach {
                                    Image(systemName: "headphones")
                                        .foregroundColor(Color.gray)
                                }
                                
                                Spacer()                             
                            }
                            .onTapGesture(perform: {
                                selectedPlayer = playerRow
                                showPlayerScreen.toggle()
                            })
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                        .background(Color.secondaryGroupedBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .padding(.horizontal)
                    }
                    .redacted(when: viewModel.isPlayersLoading)
                }
                
                Last3MonthsView(viewModel: viewModel)
                
                Spacer()
            }
            
            
        }
        .navigationTitle("Team")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.getTeamStats(teamID: team.slug)
            viewModel.getPlayers(forTeam: team.slug)
        }
    }
}

struct TeamScreen_Previews: PreviewProvider {
    static var nrg: Team = Team(id: "", slug: "23a0-nrg-esports", name: "NRG Esports", image: "https://griffon.octane.gg/teams/nrg-esports.png", region: "NA")
    static var ssg: Team = Team(id: "", slug: "2389-spacestation-gaming", name: "Spacestation Gaming", image: "https://griffon.octane.gg/teams/Spacestation_Gaming_2021.png", region: "NA")
    static var moist: Team = Team(id: "", slug: "5926-moist-esports", name: "Moist Esports", image: "https://griffon.octane.gg/teams/Moist_Esports.png", region: "EU")
    static var furia: Team = Team(id: "", slug: "c81f-furia-esports", name: "Furia Esports", image: "https://griffon.octane.gg/teams/Furia_Esports_Fixed.png", region: "SAM")
    
    static var previews: some View {
        TeamScreen(team: ssg)
            .preferredColorScheme(.light)
        TeamScreen(team: ssg)
            .preferredColorScheme(.dark)
    }
}

struct TeamHeaderView: View {
    var team: Team
    
    private var nameSplit: (String, String) {
        splitName(name: team.name)
    }
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    
                    Text(nameSplit.0)
                        .font(.system(.title).weight(.regular))
                        .foregroundColor(.primary)
                    Text(nameSplit.1)
                        .font(.system(.largeTitle).weight(.bold))
                        .foregroundColor(.primary)
                    
                }
                .padding(.leading)
                
                Spacer()
                
                UrlImageView(urlString: team.image, type: .logo)
                    .frame(width: 70, height: 70, alignment: .center)
                    .padding()
                    .background(Color.secondaryGroupedBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .padding([.trailing, .top])
                
                
            }
//            .padding(.vertical)
//           .background(Color.secondaryGroupedBackground)
//            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
//            .padding(.horizontal)
            
        }
        
    }
    
    func splitName(name: String) -> (String, String) {
        var newName = name.components(separatedBy: " ")
        guard newName.count > 1 else { return ("", name) }
        
        let lastWord = newName.removeLast()
        let theRest = newName
        return (theRest.joined(separator: " "), lastWord)
    }
}

struct Last3MonthsView: View {
    @ObservedObject var viewModel: TeamViewModel
    
    var body: some View {
        VStack {
            HStack {
                Label(
                    title: {
                        Text("Last 3 Months")
                            .font(.system(.title3, design: .default).weight(.bold))
                        
                    },
                    icon: {
                        Image(systemName: "gauge")
                            .foregroundColor(.ctrlOrange)
                    }
                )
                .padding(.vertical, 8)
                
                Spacer()
            }
            .padding([.horizontal])
            .padding(.vertical, 6)
            
            VStack {
                HStack {
                    
                    Spacer()
                    
                    VStack(spacing: 0) {
                        Text("Series")
                        
                        ProgressView(value: viewModel.teamRecord.seriesPercentage) {
                            VStack {
                                Text("\(viewModel.teamRecord.seriesPercentage * 100, specifier: "%.0f")\(Text("%").font(.system(.footnote)))")
                                    .font(.system(.headline))
                            }
                        }
                        .progressViewStyle(
                            .gauge(indicatorColor: .clear, indicatorStrokeColor: .secondaryGroupedBackground,
                                   lowerLabel: {
                                       Text("\(viewModel.teamRecord.seriesWon)")
                                           .font(.system(.caption2))
                                   }, upperLabel: {
                                       Text("\(viewModel.teamRecord.seriesLost)")
                                           .font(.system(.caption2))
                                   })
                        )
                        .frame(minWidth: 70, idealWidth: 90, maxWidth: nil, minHeight: 70, idealHeight: 90, maxHeight: nil, alignment: .center)
                    }
                    .padding(.horizontal)
                    .redacted(when: viewModel.isStatsLoading)
                    
                    Spacer()
                    
                    VStack(spacing: 0) {
                        Text("Games")
                        
                        ProgressView(value: viewModel.teamRecord.gamesPercentage) {
                            VStack {
                                Text("\(viewModel.teamRecord.gamesPercentage * 100, specifier: "%.0f")\(Text("%").font(.system(.footnote)))")
                                    .font(.system(.headline))
                            }
                        }
                        .progressViewStyle(
                            .gauge(indicatorColor: .clear, indicatorStrokeColor: .secondaryGroupedBackground,
                                   lowerLabel: {
                                       Text("\(viewModel.teamRecord.gamesWon)")
                                           .font(.system(.caption2))
                                   }, upperLabel: {
                                       Text("\(viewModel.teamRecord.gamesLost)")
                                           .font(.system(.caption2))
                                   })
                        )
                        .frame(minWidth: 70, idealWidth: 90, maxWidth: nil, minHeight: 70, idealHeight: 90, maxHeight: nil, alignment: .center)
                    }
                    .padding(.horizontal)
                    .redacted(when: viewModel.isStatsLoading)
                    
                    Spacer()
                    
                    VStack(spacing: 0) {
                        Text("OT Wins")
                        
                        ProgressView(value: viewModel.teamRecord.overtimePercentage) {
                            VStack {
                                Text("\(viewModel.teamRecord.overtimePercentage * 100, specifier: "%.0f")\(Text("%").font(.system(.footnote)))")
                                    .font(.system(.headline))
                            }
                        }
                        .progressViewStyle(
                            .gauge(indicatorColor: .clear, indicatorStrokeColor: .secondaryGroupedBackground,
                                   lowerLabel: {
                                       Text("\(viewModel.teamRecord.overtimeWin)")
                                           .font(.system(.caption2))
                                   }, upperLabel: {
                                       Text("\(viewModel.teamRecord.overtimeLosses)")
                                           .font(.system(.caption2))
                                   })
                        )
                        .frame(minWidth: 70, idealWidth: 90, maxWidth: nil, minHeight: 70, idealHeight: 90, maxHeight: nil, alignment: .center)
                    }
                    .padding(.horizontal)
                    .redacted(when: viewModel.isStatsLoading)
                    
                    Spacer()
                    
                }
                HStack {
                    
                    Spacer()
                    
                    VStack {
                        Text("Goals F/A")
                        
                        ProgressView(value: viewModel.teamRecord.goalsPercentage) {
                            VStack {
                                Text("\(viewModel.teamRecord.goalsDifferential)")
                                    .font(.system(.headline))
                            }
                        }
                        .progressViewStyle(
                            .gauge(indicatorColor: .clear, indicatorStrokeColor: .secondaryGroupedBackground,
                                   lowerLabel: {
                                       Text("\(viewModel.teamRecord.goalsFor)")
                                           .font(.system(.caption2))
                                   }, upperLabel: {
                                       Text("\(viewModel.teamRecord.goalsAgainst)")
                                           .font(.system(.caption2))
                                   })
                        )
                        .frame(minWidth: 70, idealWidth: 90, maxWidth: nil, minHeight: 70, idealHeight: 90, maxHeight: nil, alignment: .center)
                    }
                    .padding(.horizontal)
                    .redacted(when: viewModel.isStatsLoading)
                    
                    Spacer()
                    
                    VStack {
                        Text("Demos F/A")
                        
                        ProgressView(value: viewModel.teamRecord.demosPercentage) {
                            VStack {
                                Text("\(viewModel.teamRecord.demosFor - viewModel.teamRecord.demosAgainst)")
                                    .font(.system(.headline))
                            }
                        }
                        .progressViewStyle(
                            .gauge(indicatorColor: .clear, indicatorStrokeColor: .secondaryGroupedBackground,
                                   lowerLabel: {
                                       Text("\(viewModel.teamRecord.demosFor)")
                                           .font(.system(.caption2))
                                   }, upperLabel: {
                                       Text("\(viewModel.teamRecord.demosAgainst)")
                                           .font(.system(.caption2))
                                   })
                        )
                        .frame(minWidth: 70, idealWidth: 90, maxWidth: nil, minHeight: 70, idealHeight: 90, maxHeight: nil, alignment: .center)
                    }
                    .padding(.horizontal)
                    .redacted(when: viewModel.isStatsLoading)
                    
                    Spacer()
                    
                }
            }
            .padding(.vertical)
            .background(Color.secondaryGroupedBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .padding(.horizontal)
        }
    }
}
