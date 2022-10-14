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
    @ObservedObject var matchViewModel = MatchViewModel()
    var gameSelectorIsHidden: Bool {
        return match.games.isEmpty
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            MatchResultsHeaderView(match: match)
            
            if !gameSelectorIsHidden {
                GameSelectorView(match: match)
            }
            
            VStack {
                TopPerformersHeader()
                
                EventTopPerformersView(performers: matchViewModel.topPerformers)
                    .redacted(when: matchViewModel.isTopPerformersLoading)
                    .padding(.bottom)
            }
            .background(Color.secondaryGroupedBackground)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .padding(.horizontal)
            
            StatsView(blueTeam: match.blue, orangeTeam: match.orange)
        }
        .background(Color.primaryGroupedBackground)
        .onAppear {
            matchViewModel.getTopPerformers(forMatch: match.id)
        }
    }
        
}

// MARK: - Match Results Header View

struct MatchResultsHeaderView: View {
    var match: Match
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                NavigationLink(
                    destination: NavigationLazyView(
                        EventDetailView(eventID: match.event.slug)
                            .navigationBarTitleDisplayMode(.large)
                    )) {
                    
                    VStack(alignment: .leading) {
                        Text(match.event.name)
                            .multilineTextAlignment(.leading)
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
            
            ScoresView(blue: match.blue, orange: match.orange)
                .background(Color.secondaryGroupedBackground)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                .padding(.horizontal)
            
        }
    }
}

// MARK: - Game Selector View

struct GameSelectorView: View {
    var match: Match
    
    @GestureState var press = false
    @State var showGameResultsTip = false
    
    var isHidden: Bool {
        if !match.games.isEmpty {
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
        return match.games.map { $0.blue }.reduce(0, +)
    }
    
    var orangeTotalGoals: Int? {
        return match.games.map { $0.orange }.reduce(0, +)
    }
    
    var body: some View {
        
        Collapsible(text: {
            Text("Game Results")
                .font(.system(.title3, design: .default).weight(.bold))
        }, image: {
            Image(systemName: "checkmark.circle")
        }, iconColor: {
            Color.green
        }) {
            ScrollView(.horizontal, showsIndicators: false) {
                
                VStack {
                    VStack {
                        HStack {
                            // horizontal row of game scores + buttons
                            VStack {
                                
                                Text(" ") // buffer to get the alignment with the game scores right.
                                    .font(.system(.footnote, design: .rounded).weight(.light))
                                
                                UrlImageView(urlString: match.blue.teamInfo.team.image, type: .logo)
                                    .frame(width: 25, height: 25, alignment: .center)
                                
                                Divider()
                                    .opacity(1.0)
                                    .frame(width: 25, height: 3, alignment: .center)
                                
                                UrlImageView(urlString: match.orange.teamInfo.team.image, type: .logo)
                                    .frame(width: 25, height: 25, alignment: .center)
                                
                                
                            }
                            
                            ForEach(Array(match.games.enumerated()), id: \.element) { index, game in
                                GameResultSmallView(game: game, index: index + 1)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 4)
                            }
                            
                            Divider()
                            
                            VStack {
                                Text("T")
                                    .font(.system(.footnote, design: .rounded).weight(.light))
                                    .foregroundColor(Color.primary)
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
                            .background(Color.tertiaryGroupedBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                        }
                        
                        Text("* = OT")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .background(Color.secondaryGroupedBackground)
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
        return game.overtime ? "*" : ""
    }
    
    var body: some View {
        
        if game.id == "00000000" {
            NavigationLink(destination: ErrorScreen()) {
                
                VStack {
                    Text("G\(index)\(overTimeFlag)")
                        .font(.system(.footnote, design: .rounded).weight(.light))
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
            .frame(minWidth: 10)
        } else {
            NavigationLink(destination: GameScreen(gameID: game.id, gameNumber: gameNumber(index))) {
                
                VStack {
                    Text("G\(index)\(overTimeFlag)")
                        .font(.system(.footnote, design: .rounded).weight(.light))
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
            .frame(minWidth: 10)
        }
    }
    
    func gameNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        return formatter.string(from: NSNumber(integerLiteral: number))?.capitalized ?? "One"
    }
}

// MARK: - Match Stats View

struct StatsView: View {
    var blueTeam: TeamResult
    var orangeTeam: TeamResult
    @State private var selectedStatType: StatsCategory = .team
    
    var body: some View {
        VStack {
            HStack {
                Label {
                    Text("Stats")
                        .font(.system(.title3, design: .default).weight(.bold))
                } icon: {
                    Image(systemName: "chart.bar.doc.horizontal")
                        .foregroundColor(Color.purple)
                }

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
            
            ChosenStatsView(blueTeam: blueTeam, orangeTeam: orangeTeam, selectedType: $selectedStatType)
                .padding()
                .animation(.easeInOut, value: selectedStatType)
            
            
            Spacer()
            
        }
        .padding(.vertical)
        .background(Color.secondaryGroupedBackground)
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
    var blueTeam: TeamResult
    var orangeTeam: TeamResult
    
    var matchHelper: StatsHelper {
        return StatsHelper(blueTeam: blueTeam, orangeTeam: orangeTeam)
    }
    
    @Binding var selectedType: StatsType
    
    var data: [DataPoint] {
        switch selectedType {
        case .score:
            return matchHelper.getPlayerScore()
        case .goals:
            return matchHelper.getPlayerGoals()
        case .assists:
            return matchHelper.getPlayerAssists()
        case .saves:
            return matchHelper.getPlayerSaves()
        case .shots:
            return matchHelper.getPlayerShots()
        case .shotPercentage:
            return matchHelper.getPlayerShotPercentage()
        }
    }
    
    var isDecimal: Bool {
        switch selectedType {
        case .shotPercentage:
            return true
        default:
            return false
        }
    }
    
    var body: some View {
        PlayersStatsChartView(dataPoints: data, isDecimal: isDecimal)
    }
}

// MARK: - Players Stats Chart View

struct PlayersStatsChartView: View {
    var dataPoints: [DataPoint]
    var isDecimal: Bool
    
    var body: some View {
        HorizontalBarChartView(dataPoints: dataPoints, isDecimal: false, separator: " -") { bar in
            if isDecimal {
                return Text(bar.legend.label) + Text("- \(bar.value.percentage)")
            } else {
                return Text(bar.legend.label) + Text("- \(bar.value, specifier: "%.0f")")
            }
        }
    }
}

struct ChosenStatsView: View {
    var blueTeam: TeamResult
    var orangeTeam: TeamResult
    @Binding var selectedType: StatsCategory
    
    var body: some View {
        switch selectedType {
        case .team:
                TeamStatsView(blueTeam: blueTeam, orangeTeam: orangeTeam)
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
        case .players:
                PlayersStatsView(blueTeam: blueTeam, orangeTeam: orangeTeam)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
        }
    }
}

// MARK: - Team Stats View

struct TeamsChosenStatsView: View {
    var blueTeam: TeamResult
    var orangeTeam: TeamResult
    
    var matchHelper: StatsHelper {
        return StatsHelper(blueTeam: blueTeam, orangeTeam: orangeTeam)
    }
    
    @Binding var selectedType: StatsType
    
    var data: [DataPoint] {
        switch selectedType {
        case .score:
            return matchHelper.getTeamScore()
        case .goals:
            return matchHelper.getTeamGoals()
        case .assists:
            return matchHelper.getTeamAssists()
        case .saves:
            return matchHelper.getTeamSaves()
        case .shots:
            return matchHelper.getTeamShots()
        case .shotPercentage:
            return matchHelper.getTeamShotPercentage()
        }
    }
    
    var isDecimal: Bool {
        switch selectedType {
        case .shotPercentage:
            return true
        default:
            return false
        }
    }
    
    var body: some View {
            TeamStatsChartView(dataPoints: data, isDecimal: isDecimal)
    }
}

// MARK: - Players Stats Chart View

struct TeamStatsChartView: View {
    var dataPoints: [DataPoint]
    var isDecimal: Bool
    
    var body: some View {
        HorizontalBarChartView(dataPoints: dataPoints, isDecimal: false, separator: " -", text: { bar in
            if isDecimal {
                return Text("\(bar.value.percentage)")
            } else {
                return Text("\(bar.value, specifier: "%.0f")")
            }
        })
            .chartStyle(BarChartStyle(showLegends: true))
    }
}

struct TeamStatsView: View {
    var blueTeam: TeamResult
    var orangeTeam: TeamResult
    
    var statsHelper: StatsHelper {
        return StatsHelper(blueTeam: blueTeam, orangeTeam: orangeTeam)
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
            
            TeamsChosenStatsView(blueTeam: blueTeam, orangeTeam: orangeTeam, selectedType: $pickerSelection)
                .animation(.easeInOut, value: pickerSelection)
            
            HorizontalBarChartView(dataPoints: statsHelper.getTeamNames(), text: { bar in
                Text(bar.legend.label)
            })
            
            
            Spacer()
        }
    }
}

// MARK: - Player Stats View


struct PlayersStatsView: View {    
    var blueTeam: TeamResult
    var orangeTeam: TeamResult
    
    var statsHelper: StatsHelper {
        return StatsHelper(blueTeam: blueTeam, orangeTeam: orangeTeam)
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
            
            PlayersChosenStatsView(blueTeam: blueTeam, orangeTeam: orangeTeam, selectedType: $pickerSelection)
                .animation(.easeInOut, value: pickerSelection)
            
            Spacer()
        }
    }
}

// MARK: - Preview

struct MatchResultView_Previews: PreviewProvider {
    static var previews: some View {
        MatchResultView(match: ExampleData.match)
    }
}


extension Animation {
    static func ripple(index: Int) -> Animation {
        Animation.spring(dampingFraction: 0.5)
            .speed(2)
            .delay(0.03 * Double(index))
    }
}

struct ScoresView: View {
    
    var blue: TeamResult
    var orange: TeamResult
    
    var blueNameSplit: (String, String) {
        splitName(name: blue.teamInfo.team.name)
    }
    
    var orangeNameSplit: (String, String) {
        splitName(name: orange.teamInfo.team.name)
    }
    
    private var inProgress: Bool {
        if !blue.winner && !orange.winner {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        VStack {
            // logos and scores
            HStack {
                
                Spacer()
                
                NavigationLink(
                    destination: TeamScreen(team: blue.teamInfo.team),
                    label: {
                        UrlImageView(urlString: blue.teamInfo.team.image, type: .logo)
                            .frame(width: 100, height: 75, alignment: .center)
                            .padding(.trailing)
                    })
                
                Text("\(blue.score)")
                    .font(.system(.largeTitle, design: .rounded).weight(blue.winner ? .bold : .regular))
                    .foregroundColor(inProgress ? .primary : (blue.winner ? .green : .red))
                
                Text("-")
                    .font(.system(.title, design: .rounded).weight(.bold))
                
                Text("\(orange.score)")
                    .font(.system(.largeTitle, design: .rounded).weight(orange.winner ? .bold : .regular))
                    .foregroundColor(inProgress ? .primary : (orange.winner ? .green : .red))
                
                NavigationLink(
                    destination: TeamScreen(team: orange.teamInfo.team),
                    label: {
                        UrlImageView(urlString: orange.teamInfo.team.image, type: .logo)
                            .frame(width: 100, height: 75, alignment: .center)
                            .padding(.leading)
                    })
                
                Spacer()
            }
            .padding(.top)
            
            // teams names
            HStack {
                
                NavigationLink(
                    destination: TeamScreen(team: blue.teamInfo.team),
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
                    destination: TeamScreen(team: orange.teamInfo.team),
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
    }
    
    func splitName(name: String) -> (String, String) {
        var newName = name.components(separatedBy: " ")
        guard newName.count > 1 else { return ("", name) }
        
        let lastWord = newName.removeLast()
        let theRest = newName
        return (theRest.joined(separator: " "), lastWord)
    }
}
