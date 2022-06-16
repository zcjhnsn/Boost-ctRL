//
//  PlayerScreen.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 6/13/22.
//

import SwiftUI

struct PlayerScreen: View {
    @StateObject var viewModel = PlayerViewModel()
    
    @State private var showPlayerScreen = false
    @State private var chosenTeammate = ExampleData.player
    
    var playerID: String
    var name: String = ""
    var country: String = ""
    
    var body: some View {
        ZStack {
            Color.primaryGroupedBackground
            
            ScrollView(.vertical, showsIndicators: false) {
                PlayerHeaderView(player: viewModel.player)
                
                VStack(spacing: 0) {
                    HStack {
                        Label(
                            title: {
                                Text("Teammates")
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
                        PlayerScreen(playerID: chosenTeammate.slug)
                    }
                    .hidden()
                    
                    VStack {
                        ForEach(viewModel.teammates, id: \.slug) { teammate in
                            if teammate.slug != playerID {
                                HStack {
                                    Text(IsoCountries.flag(countryCode: teammate.country) ?? "🌎")
                                    
                                    Text(teammate.tag)
                                    
                                    if teammate.substitute {
                                        Text("S")
                                            .foregroundColor(Color.gray)
                                    }
                                    
                                    if teammate.coach {
                                        Image(systemName: "headphones")
                                            .foregroundColor(Color.gray)
                                    }
                                    
                                    Spacer()
                                    
                                }
                                .onTapGesture(perform: {
                                    chosenTeammate = teammate
                                    showPlayerScreen.toggle()
                                })
                                .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                        .background(Color.secondaryGroupedBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .padding(.horizontal)
                    }
                    .redacted(when: viewModel.isPlayersLoading)
                }
                
                PlayerLast3MonthsView(viewModel: viewModel)
                
                Spacer()
            }
            
            
        }
        .navigationTitle("Team")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.getPlayerStats(playerID: playerID)
            viewModel.getPlayerInfo(playerId: playerID)
//            viewModel.getTeamStats(teamID: team.slug)
//            viewModel.getPlayers(forTeam: team.slug)
        }
    }
}

struct PlayerHeaderView: View {
    var player: Player
    
    @State var showTeamScreen = false
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(player.tag)
                        .font(.system(.largeTitle).weight(.bold))
                        .foregroundColor(.primary)
                        .padding(.top)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("\(IsoCountries.flag(countryCode: player.country) ?? "🌎") \(player.name)")
                            .font(.system(.subheadline))
                            .foregroundColor(.primary)
                        
                        Text("\(getRole()) for \(player.team.name)")
                            .font(.system(.subheadline).weight(.light))
                            .foregroundColor(.primary)
                            .onTapGesture {
                                showTeamScreen.toggle()
                            }
                    }
                    
                    NavigationLink("Team Info", isActive: $showTeamScreen) {
                        TeamScreen(team: player.team)
                    }
                    .hidden()
                    
                }
                .padding(.leading)
                
                Spacer()
                
                UrlImageView(urlString: player.team.image, type: .logo)
                    .frame(width: 70, height: 70, alignment: .center)
                    .padding()
                    .background(Color.secondaryGroupedBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .padding(.trailing)
                    .padding(.top)
                    .onTapGesture {
                        showTeamScreen.toggle()
                    }
                
                
            }
        }
        
    }
    
    private func getRole() -> String {
        var roles: [String] = []
        
        if player.substitute {
            roles.append("Sub")
        }
        
        if player.coach {
            roles.append("Coach")
        }
        
        if roles.isEmpty {
            roles.append("Player")
        }
        
        return roles.joined(separator: "/")
    }
}

struct PlayerLast3MonthsView: View {
    @ObservedObject var viewModel: PlayerViewModel
    
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
            
            VStack(spacing: 6) {
                HStack {
                    
                    Spacer()
                    
                    VStack(spacing: 4) {
                        Text("Series")
                            .font(.system(.body).smallCaps())
                        
                        Text("\(viewModel.record.seriesWon) - \(viewModel.record.seriesLost)")
                            .font(.system(.title3).weight(.bold))
                        
                        Text("\(viewModel.record.seriesPercentage * 100, specifier: "%.0f")%")
                            .font(.system(.body).weight(.light))
                            .foregroundColor(.gray)
                        
                        
                    }
                    .padding(.horizontal)
                    .redacted(when: viewModel.isStatsLoading)
                    
                    Spacer()
                    
                    VStack(spacing: 4) {
                        Text("Games")
                            .font(.system(.body).smallCaps())
                        
                        Text("\(viewModel.record.gamesWon) - \(viewModel.record.gamesLost)")
                            .font(.system(.title3).weight(.bold))
                        
                        Text("\(viewModel.record.gamesPercentage * 100, specifier: "%.0f")%")
                            .font(.system(.body).weight(.light))
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    .redacted(when: viewModel.isStatsLoading)
                    
                    Spacer()
                    
                    VStack(spacing: 4) {
                        Text("Shooting")
                            .font(.system(.body).smallCaps())
                        
                        Text("\(viewModel.record.shotPercentage, specifier: "%.2f")%")
                            .font(.system(.title3).weight(.bold))
                        
                        Text("\(viewModel.record.goalsPerGame, specifier: "%.2f") goals")
                            .font(.system(.body).weight(.light))
                            .foregroundColor(.gray)
                        
                        
                    }
                    .padding(.horizontal)
                    .redacted(when: viewModel.isStatsLoading)
                    
                    Spacer()
                    
                }
                HStack {
                    
                    Spacer()
                    
                    VStack(spacing: 4) {
                        Text("Demos")
                            .font(.system(.body).smallCaps())
                        
                        Text("\(viewModel.record.demosInflictedPerGame, specifier: "%.2f")")
                            .font(.system(.title3).weight(.bold))
                        
                        Text("\(viewModel.record.demosTakenPerGame * 100, specifier: "%.2f") taken")
                            .font(.system(.body).weight(.light))
                            .foregroundColor(.gray)
                        
                        
                    }
                    .padding(.horizontal)
                    .redacted(when: viewModel.isStatsLoading)
                    
                    Spacer()
                    
                    VStack(spacing: 4) {
                        Text("Rating")
                            .font(.system(.body).smallCaps())
                        
                        Text("\(viewModel.record.rating, specifier: "%.2f")")
                            .font(.system(.title3).weight(.bold))
                        
                        Text("\(viewModel.record.gamesTotal) games")
                            .font(.system(.body).weight(.light))
                            .foregroundColor(.gray)
                        
                        
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


struct PlayerScreen_Previews: PreviewProvider {
    static var previews: some View {
        PlayerScreen(playerID: ExampleData.player.slug)
    }
}
