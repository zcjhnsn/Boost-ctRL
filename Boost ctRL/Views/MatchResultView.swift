//
//  MatchResultView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/6/21.
//

import SwiftUI
import SwiftUICharts

// MARK: - Match Results View

struct MatchResultView: View {
    var match: Match
    var gameSelectorIsHidden: Bool {
        return match.games?.isEmpty ?? true
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            MatchResultsHeaderView(match: match)
            
            if !gameSelectorIsHidden {
                GameSelectorView(match: match)
            }
            
            MatchStatsView(match: match)
        }
    }
}

// MARK: - Match Results Header View

struct MatchResultsHeaderView: View {
    var match: Match
    
    var blueNameSplit: (String, String) {
        splitName(name: match.blue.teamInfo.team.name)
    }
    
    var orangeNameSplit: (String, String) {
        splitName(name: match.orange.teamInfo.team.name)
    }
    
    var inProgress: Bool {
        if !match.blue.winner && !match.orange.winner {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                NavigationLink(
                    destination:  NavigationLazyView(
                        EventDetailView(eventID: match.event.id)
                            .navigationBarTitleDisplayMode(.large)
                            .navigationTitle(Text("Event Overview"))
                    )) {
                    
                    VStack(alignment: .leading) {
                        Text(match.event.name)
                            .font(.system(.subheadline).weight(.bold))
                            .foregroundColor(.primary)
                        
                        Text(match.stage.name)
                            .font(.system(.subheadline).weight(.regular))
                            .foregroundColor(.primary)
                        
                        Text("\(match.date.dateToLocal(option: .dateTime))")
                            .font(.system(.subheadline).weight(.light))
                            .foregroundColor(.primary)
                        
                    }
                    .padding([.leading, .bottom])
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.primary)
                        .padding()
                }
            }
            
            VStack {
                
                
                // logos and scores
                HStack {
                    
                    Spacer()
                    
                    UrlImageView(urlString: match.blue.teamInfo.team.image, type: .logo)
                        .frame(width: 100, height: 75, alignment: .center)
                        .padding(.trailing)
                    
                    Text("\(match.blue.score)")
                        .font(.system(.largeTitle, design: .rounded).weight(.bold))
                        .foregroundColor(inProgress ? .black : (match.blue.winner ? .green : .red))
                    
                    Text("-")
                        .font(.system(.title, design: .rounded).weight(.bold))
                    
                    Text("\(match.orange.score)")
                        .font(.system(.largeTitle, design: .rounded).weight(.bold))
                        .foregroundColor(inProgress ? .black : (match.orange.winner ? .green : .red))
                    
                    UrlImageView(urlString: match.orange.teamInfo.team.image, type: .logo)
                        .frame(width: 100, height: 75, alignment: .center)
                        .padding(.leading)
                    
                    Spacer()
                }
                .padding(.top)
                
                // teams names
                HStack {
                    
                    NavigationLink(
                        destination: Text("\(match.blue.teamInfo.team.name)"),
                        label: {
                            VStack(alignment: .leading) {
                                Text(blueNameSplit.0)
                                    .font(.system(.body).weight(.light))
                                    .foregroundColor(.primary)
                                Text(blueNameSplit.1)
                                    .font(.system(.headline).weight(.semibold))
                                    .foregroundColor(.primary)
                            }
                            .padding(.leading)
                        })
                    
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: Text("\(match.orange.teamInfo.team.name)"),
                        label: {
                            VStack(alignment: .trailing) {
                                Text(orangeNameSplit.0)
                                    .font(.system(.body).weight(.light))
                                    .foregroundColor(.primary)
                                Text(orangeNameSplit.1)
                                    .font(.system(.headline).weight(.semibold))
                                    .foregroundColor(.primary)
                            }
                            .padding(.trailing)
                        })
                    
                }
                .padding(.horizontal)
                .padding(.bottom)
                
            }
            .background(Color(UIColor.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .padding(.horizontal)
            
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

// MARK: - Game Selector View

struct GameSelectorView: View {
    var match: Match
    
    @GestureState var press = false
    @State var showGameResultsTip = false
    
    var isHidden: Bool {
        if let games = match.games, games.count > 0 {
            return false
        } else { return true }
    }
    
    var matchResultColors: (Color, Color) {
        return match.blue.score > match.orange.score ? (.green, .red) : (.red, .green)
    }
    
    var matchResultFont: (Font, Font) {
        return match.blue.score > match.orange.score ? (winnerFont, loserFont) : (loserFont, winnerFont)
    }
    
    let winnerFont = Font.system(.body, design: .rounded)
        .weight(.bold)
    let loserFont = Font.system(.body, design: .rounded)
        .weight(.regular)
    
    var blueTotalGoals: Int? {
        return match.games?.map { $0.blue }.reduce(0, +)
    }
    
    var orangeTotalGoals: Int? {
        return match.games?.map { $0.orange }.reduce(0, +)
    }
    
    var body: some View {
        
        Collapsible(label: {
            Text("Game Results")
                .font(.system(.title3, design: .default).weight(.bold))
        }) {
            
            VStack {
                VStack {
                    HStack {
                        // horizontal row of game scores + buttons
                        VStack {
                            
                            Text(" ") // buffer to get the alignment with the game scores right.
                            
                            UrlImageView(urlString: match.blue.teamInfo.team.image, type: .logo)
                                .frame(width: 25, height: 25, alignment: .center)
                            
                            Divider()
                                .opacity(1.0)
                                .frame(width: 25, height: 3, alignment: .center)
                            
                            UrlImageView(urlString: match.orange.teamInfo.team.image, type: .logo)
                                .frame(width: 25, height: 25, alignment: .center)
                            
                            
                        }
                        
                        ForEach(Array((match.games ?? []).enumerated()), id: \.element) { index, game in
                            GameResultSmallView(game: game, index: index + 1)
                                .padding(.horizontal, 4)
                                .padding(.vertical, 4)
                        }
                        
                        Divider()
                        
                        VStack {
                            Text("T")
                                .font(.system(.callout, design: .rounded).weight(.light))
                                .foregroundColor(Color(.tertiaryLabel))
                                .padding(.bottom, 4)
                            
                            Text("\(blueTotalGoals ?? 0)")
                                .font(matchResultFont.0)
                                .foregroundColor(matchResultColors.0)
                            
                            
                            Divider()
                                .opacity(0)
                                .frame(width: 25, height: 3, alignment: .center)
                            
                            Text("\(orangeTotalGoals ?? 0)")
                                .font(matchResultFont.1)
                                .foregroundColor(matchResultColors.1)
                        }
                        .padding(.horizontal, 4)
                        .padding(.vertical, 4)
                        .background(Color(.tertiarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                    }
                    
                    Text("* = OT")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .padding( .horizontal)
        .longPressAlert(title: "Game Results Help", message: "Tap a game result to see details for that game", dismissButton: .default(Text("Okay")))
        .alert(isPresented: $showGameResultsTip, content: {
            Alert(title: Text("Game Results Help"), message: Text("Tap a game result to see details for that game"), dismissButton: .default(Text("Okay")))
        })
        
        
    }
}

// MARK: - Game Result Small View

struct GameResultSmallView: View {
    var game: Game
    var index: Int
    
    let winnerFont = Font.system(.body, design: .rounded)
        .weight(.bold)
    let loserFont = Font.system(.body, design: .rounded)
        .weight(.regular)
    
    var gameResultColors: (Color, Color) {
        return game.blue > game.orange ? (.green, .red) : (.red, .green)
    }
    
    var gameResultFont: (Font, Font) {
        return game.blue > game.orange ? (winnerFont, loserFont) : (loserFont, winnerFont)
    }
    
    var overTimeFlag: String {
        return game.overtime ?? false ? "*" : ""
    }
    
    var body: some View {
        
        NavigationLink(destination: NavigationLazyView(Text("\(game.id)"))) {
            
            VStack {
                Text("G\(index)\(overTimeFlag)")
                    .font(.system(.callout, design: .rounded).weight(.light))
                    .foregroundColor(.secondary)
                    .padding(.bottom, 4)
                
                Text("\(game.blue)")
                    .font(gameResultFont.0)
                    .foregroundColor(gameResultColors.0)
                
                
                Divider()
                    .opacity(0)
                    .frame(width: 25, height: 3, alignment: .center)
                
                Text("\(game.orange)")
                    .font(gameResultFont.1)
                    .foregroundColor(gameResultColors.1)
            }
            
        }
    }
}

// MARK: - Match Wrapper View


struct MatchStatsWrapperView: View {
    var match: Match
    
    var body: some View {
        Collapsible(label: {
            Text("Match Stats")
                .font(.system(.title3, design: .default).weight(.bold))
        }) {
            VStack {
                MatchStatsView(match: match)
            }
        }
    }
    
    
}

// MARK: - Match Stats View

struct MatchStatsView: View {
    var match: Match
    @State private var selectedStatType: StatsCategory = .team
    
    var body: some View {
        VStack {
            HStack {
                Text("Stats")
                    .font(.system(.title3, design: .default).weight(.bold))
                    
                
                Spacer()
            }
            .padding(.leading)
            
            Picker("Select Stats for Team or Players", selection: self.$selectedStatType.animation()) {
                ForEach(StatsCategory.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding([.horizontal, .top])
            
            
            Spacer()
            
            ChosenStatsView(match: match, selectedType: $selectedStatType)
                .padding()
                .transition(.opacity)
                .animation(.easeInOut)
            
            
            Spacer()
            
        }
        .padding(.vertical)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .padding([.horizontal, .bottom])
        
        
        
    }
}

// MARK: - Stats Category

enum StatsCategory: String, CaseIterable {
    case team = "Team"
    case players = "Players"
}

// MARK: - Stats Type

enum StatsType: String, CaseIterable {
    case score = "Score"
    case goals = "Goals"
    case assists = "Assists"
    case saves = "Saves"
    case shots = "Shots"
    case shotPercentage = "Shot %"
}

// MARK: - Players Chosen Stats View
struct PlayersChosenStatsView: View {
    var match: Match
    
    var matchHelper: MatchStatsHelper {
        return MatchStatsHelper(match: match)
    }
    
    @Binding var selectedType: StatsType
    
    var body: some View {
        switch selectedType {
        case .score:
            PlayersStatsChartView(dataPoints: matchHelper.getPlayerScore(), isDecimal: false)
                    .transition(.opacity)
        case .goals:
            PlayersStatsChartView(dataPoints: matchHelper.getPlayerGoals(), isDecimal: false)
                    .transition(.opacity)
        case .assists:
            PlayersStatsChartView(dataPoints: matchHelper.getPlayerAssists(), isDecimal: false)
                    .transition(.opacity)
        case .saves:
            PlayersStatsChartView(dataPoints: matchHelper.getPlayerSaves(), isDecimal: false)
                    .transition(.opacity)
        case .shots:
            PlayersStatsChartView(dataPoints: matchHelper.getPlayerShots(), isDecimal: false)
                    .transition(.opacity)
        case .shotPercentage:
            PlayersStatsChartView(dataPoints: matchHelper.getPlayerShotPercentage(), isDecimal: true)
                    .transition(.opacity)
        }
    }
}

// MARK: - Players Stats Chart View

struct PlayersStatsChartView: View {
    var dataPoints: [DataPoint]
    var isDecimal: Bool
    
    var body: some View {
        if isDecimal {
            HorizontalBarChartView(dataPoints: dataPoints) { point in
                Text(point.legend.label) + Text(" - ") + Text(point.value.percentage).bold()
            }
            
        } else {
            HorizontalBarChartView(dataPoints: dataPoints, isDecimal: false, separator: " -")
        }
    }
}

struct ChosenStatsView: View {
    var match: Match
    @Binding var selectedType: StatsCategory
    
    var body: some View {
        switch selectedType {
        case .team:
                TeamStatsView(match: match)
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
        case .players:
                PlayersStatsView(match: match)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
        }
    }
}

// MARK: - Team Stats View


struct TeamStatsView: View {
    var match: Match
    
    var statsHelper: MatchStatsHelper {
        return MatchStatsHelper(match: match)
    }
    
    var body: some View {
        
        VStack {
            HorizontalBarChartView(dataPoints: statsHelper.getTeamNames(), text: { point in
                Text(point.legend.label)
            })
            .padding(.bottom)
            
            
            Group {
                HStack {
                    Text("Score")
                        .font(.system(.headline, design: .default).weight(.bold))
                    
                    Spacer()
                }
                
                if statsHelper.getTeamScore().isEmpty {
                    
                    Text("No stats available")
                        .foregroundColor(.secondary)
                    
                } else {
                    HorizontalBarChartView(dataPoints: statsHelper.getTeamScore(), separator: " -", text: { point in
                        Text("\(Int(point.value))")
                    })
                }
                
                Divider()
                
                HStack {
                    Text("Goals")
                        .font(.system(.headline, design: .default).weight(.bold))
                    
                    Spacer()
                }
                
                if statsHelper.getTeamGoals().isEmpty {
                    
                    Text("No stats available")
                        .foregroundColor(.secondary)
                    
                } else {
                    HorizontalBarChartView(dataPoints: statsHelper.getTeamGoals(), separator: " -", text: { point in
                        Text("\(Int(point.value))")
                    })
                }
                Divider()
                
                /*
                 let shots, goals, saves, assists: Int
                 let score: Int
                 let shootingPercentage: Double
                 */
                
                HStack {
                    Text("Assists")
                        .font(.system(.headline, design: .default).weight(.bold))
                    
                    Spacer()
                }
                
                if statsHelper.getTeamAssists().isEmpty {
                    
                    Text("No stats available")
                        .foregroundColor(.secondary)
                    
                } else {
                    HorizontalBarChartView(dataPoints: statsHelper.getTeamAssists(), separator: " -", text: { point in
                        Text("\(Int(point.value))")
                    })
                }
                
                Divider()
            }
            
            Group {
                
                HStack {
                    Text("Saves")
                        .font(.system(.headline, design: .default).weight(.bold))
                    
                    Spacer()
                }
                
                if statsHelper.getTeamSaves().isEmpty {
                    
                    Text("No stats available")
                        .foregroundColor(.secondary)
                    
                } else {
                    HorizontalBarChartView(dataPoints: statsHelper.getTeamSaves(), separator: " -", text: { point in
                        Text("\(Int(point.value))")
                    })
                }
                
                Divider()
                
                HStack {
                    Text("Shots")
                        .font(.system(.headline, design: .default).weight(.bold))
                    
                    Spacer()
                }
                
                if statsHelper.getTeamShots().isEmpty {
                    
                    Text("No stats available")
                        .foregroundColor(.secondary)
                    
                } else {
                    HorizontalBarChartView(dataPoints: statsHelper.getTeamShots(), separator: " -", text: { point in
                        Text("\(Int(point.value))")
                    })
                }
                
                Divider()
                
                HStack {
                    Text("Shooting Percentage")
                        .font(.system(.headline, design: .default).weight(.bold))
                    
                    Spacer()
                }
                
                if statsHelper.getTeamShotPercentage().isEmpty {
                    
                    Text("No stats available")
                        .foregroundColor(.secondary)
                    
                } else {
                    HorizontalBarChartView(dataPoints: statsHelper.getTeamShotPercentage(), separator: " -", text: { point in
                        Text("\(point.value.percentage)")
                    })
                }
            }
            
            
            
        }
//        .padding(.horizontal)
    }
}

// MARK: - Player Stats View


struct PlayersStatsView: View {    
    var match: Match
    
    var statsHelper: MatchStatsHelper {
        return MatchStatsHelper(match: match)
    }
    
    @State var pickerSelection: StatsType = .score
    
    var body: some View {
        VStack {
            Picker("Select a stat type", selection: $pickerSelection) {
                ForEach(StatsType.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom)
            
            Spacer()
            
            PlayersChosenStatsView(match: match, selectedType: $pickerSelection)
                .animation(.easeInOut)
            
            Spacer()
        }
    }
}

// MARK: - Preview

struct MatchResultView_Previews: PreviewProvider {
    static var previews: some View {
        MatchResultView(match: PreviewHelper.MATCH)
    }
}


extension Animation {
    static func ripple(index: Int) -> Animation {
        Animation.spring(dampingFraction: 0.5)
            .speed(2)
            .delay(0.03 * Double(index))
    }
}
