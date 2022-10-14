//
//  GameScreen.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 6/21/22.
//

import SwiftUI
import SwiftUICharts

// MARK: - Match Results View

//struct MatchResultView: View {
//    var match: Match
//    @ObservedObject var matchViewModel = MatchViewModel()
//    var gameSelectorIsHidden: Bool {
//        return match.games.isEmpty
//    }
//
//    var body: some View {
//        ScrollView(.vertical, showsIndicators: false) {
//
//            MatchResultsHeaderView(match: match)
//
//            if !gameSelectorIsHidden {
//                GameSelectorView(match: match)
//            }
//
//            VStack {
//                TopPerformersHeader()
//
//                EventTopPerformersView(performers: matchViewModel.topPerformers)
//                    .redacted(when: matchViewModel.isTopPerformersLoading)
//                    .padding(.bottom)
//            }
//            .background(Color.secondaryGroupedBackground)
//            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
//            .padding(.horizontal)
//
//            MatchStatsView(match: match)
//        }
//        .background(Color.primaryGroupedBackground)
//        .onAppear {
//            matchViewModel.getTopPerformers(forMatch: match.id)
//        }
//    }
//
//}

//
//// MARK: - Match Stats View
//
//struct MatchStatsView: View {
//    var match: Match
//    @State private var selectedStatType: StatsCategory = .team
//
//    var body: some View {
//        VStack {
//            HStack {
//                Label {
//                    Text("Stats")
//                        .font(.system(.title3, design: .default).weight(.bold))
//                } icon: {
//                    Image(systemName: "chart.bar.doc.horizontal")
//                        .foregroundColor(Color.purple)
//                }
//
//                Spacer()
//            }
//            .padding(.leading)
//
//            Picker("Select Stats for Team or Players", selection: self.$selectedStatType.animation()) {
//                ForEach(StatsCategory.allCases, id: \.self) {
//                    Text($0.rawValue)
//                }
//            }
//            .pickerStyle(SegmentedPickerStyle())
//            .padding([.horizontal, .top])
//
//
//            Spacer()
//
//            ChosenStatsView(match: match, selectedType: $selectedStatType)
//                .padding()
//                .animation(.easeInOut, value: selectedStatType)
//
//
//            Spacer()
//
//        }
//        .padding(.vertical)
//        .background(Color.secondaryGroupedBackground)
//        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
//        .padding([.horizontal, .bottom])
//
//    }
//}
//
//// MARK: - Stats Category
//
//enum StatsCategory: String, CaseIterable {
//    case team = "Team"
//    case players = "Players"
//}
//
//// MARK: - Stats Type
//
//enum StatsType: String, CaseIterable {
//    case score = "Score"
//    case goals = "Goals"
//    case assists = "Assists"
//    case saves = "Saves"
//    case shots = "Shots"
//    case shotPercentage = "Shot %"
//}
//
//// MARK: - Players Chosen Stats View
//struct PlayersChosenStatsView: View {
//    var match: Match
//
//    var matchHelper: MatchStatsHelper {
//        return MatchStatsHelper(match: match)
//    }
//
//    @Binding var selectedType: StatsType
//
//    var data: [DataPoint] {
//        switch selectedType {
//        case .score:
//            return matchHelper.getPlayerScore()
//        case .goals:
//            return matchHelper.getPlayerGoals()
//        case .assists:
//            return matchHelper.getPlayerAssists()
//        case .saves:
//            return matchHelper.getPlayerSaves()
//        case .shots:
//            return matchHelper.getPlayerShots()
//        case .shotPercentage:
//            return matchHelper.getPlayerShotPercentage()
//        }
//    }
//
//    var isDecimal: Bool {
//        switch selectedType {
//        case .shotPercentage:
//            return true
//        default:
//            return false
//        }
//    }
//
//    var body: some View {
//            PlayersStatsChartView(dataPoints: data, isDecimal: isDecimal)
//    }
//}
//
//// MARK: - Players Stats Chart View
//
//struct PlayersStatsChartView: View {
//    var dataPoints: [DataPoint]
//    var isDecimal: Bool
//
//    var body: some View {
//        HorizontalBarChartView(dataPoints: dataPoints, isDecimal: false, separator: " -") { bar in
//            if isDecimal {
//                return Text(bar.legend.label) + Text("- \(bar.value.percentage)")
//            } else {
//                return Text(bar.legend.label) + Text("- \(bar.value, specifier: "%.0f")")
//            }
//        }
//    }
//}
//
//struct ChosenStatsView: View {
//    var match: Match
//    @Binding var selectedType: StatsCategory
//
//    var body: some View {
//        switch selectedType {
//        case .team:
//                TeamStatsView(match: match)
//                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
//        case .players:
//                PlayersStatsView(match: match)
//                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
//        }
//    }
//}
//
//// MARK: - Team Stats View
//
//struct TeamsChosenStatsView: View {
//    var match: Match
//
//    var matchHelper: MatchStatsHelper {
//        return MatchStatsHelper(match: match)
//    }
//
//    @Binding var selectedType: StatsType
//
//    var data: [DataPoint] {
//        switch selectedType {
//        case .score:
//            return matchHelper.getTeamScore()
//        case .goals:
//            return matchHelper.getTeamGoals()
//        case .assists:
//            return matchHelper.getTeamAssists()
//        case .saves:
//            return matchHelper.getTeamSaves()
//        case .shots:
//            return matchHelper.getTeamShots()
//        case .shotPercentage:
//            return matchHelper.getTeamShotPercentage()
//        }
//    }
//
//    var isDecimal: Bool {
//        switch selectedType {
//        case .shotPercentage:
//            return true
//        default:
//            return false
//        }
//    }
//
//    var body: some View {
//            TeamStatsChartView(dataPoints: data, isDecimal: isDecimal)
//    }
//}
//
//// MARK: - Players Stats Chart View
//
//struct TeamStatsChartView: View {
//    var dataPoints: [DataPoint]
//    var isDecimal: Bool
//
//    var body: some View {
//        HorizontalBarChartView(dataPoints: dataPoints, isDecimal: false, separator: " -", text: { bar in
//            if isDecimal {
//                return Text("\(bar.value.percentage)")
//            } else {
//                return Text("\(bar.value, specifier: "%.0f")")
//            }
//        })
//            .chartStyle(BarChartStyle(showLegends: true))
//    }
//}
//
//struct TeamStatsView: View {
//    var match: Match
//
//    var statsHelper: MatchStatsHelper {
//        return MatchStatsHelper(match: match)
//    }
//
//    @State var pickerSelection: StatsType = .score
//
//    var body: some View {
//        VStack {
//            Picker("Select a stat type", selection: $pickerSelection) {
//                ForEach(StatsType.allCases, id: \.self) { type in
//                    Text(type.rawValue)
//                }
//            }
//            .pickerStyle(SegmentedPickerStyle())
//            .padding(.bottom)
//
//            Spacer()
//
//            TeamsChosenStatsView(match: match, selectedType: $pickerSelection)
//                .animation(.easeInOut, value: pickerSelection)
//
//            HorizontalBarChartView(dataPoints: statsHelper.getTeamNames(), text: { bar in
//                Text(bar.legend.label)
//            })
//
//
//            Spacer()
//        }
//    }
//}
//
//// MARK: - Player Stats View
//
//
//struct PlayersStatsView: View {
//    var match: Match
//
//    var statsHelper: MatchStatsHelper {
//        return MatchStatsHelper(match: match)
//    }
//
//    @State var pickerSelection: StatsType = .score
//
//    var body: some View {
//        VStack {
//            Picker("Select a stat type", selection: $pickerSelection) {
//                ForEach(StatsType.allCases, id: \.self) { type in
//                    Text(type.rawValue)
//                }
//            }
//            .pickerStyle(SegmentedPickerStyle())
//            .padding(.bottom)
//
//            Spacer()
//
//            PlayersChosenStatsView(match: match, selectedType: $pickerSelection)
//                .animation(.easeInOut, value: pickerSelection)
//
//            Spacer()
//        }
//    }
//}
//
//// MARK: - Preview
//
//struct MatchResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        MatchResultView(match: ExampleData.match)
//    }
//}
//
//
//extension Animation {
//    static func ripple(index: Int) -> Animation {
//        Animation.spring(dampingFraction: 0.5)
//            .speed(2)
//            .delay(0.03 * Double(index))
//    }
//}


struct GameScreen: View {
    var gameID: String
    var gameNumber: String
    @StateObject var gameViewModel = GameViewModel()
    

    var body: some View {
        ZStack {
            Color.primaryGroupedBackground
            ScrollView(showsIndicators: false) {
                GameResultsHeaderView(game: gameViewModel.game)
                
                GameInfoView(game: gameViewModel.game)
                    .padding(.horizontal)
                
                
                VStack {
                    TopPerformersHeader()
                    
                    EventTopPerformersView(performers: gameViewModel.topPerformers)
                        .redacted(when: gameViewModel.isGameLoading)
                    
                }
                .background(Color.secondaryGroupedBackground)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                .padding([.horizontal, .bottom])
                
                StatsView(blueTeam: gameViewModel.game.blue, orangeTeam: gameViewModel.game.orange)
            }
            .navigationTitle("Game \(gameNumber)")
            
        }
        .background(Color.primaryGroupedBackground)
        .onAppear {
            gameViewModel.getGame(byID: gameID)
        }
    }
}

struct GameInfoView: View {
    var game: GameResult
    
    func getReadableDate(from eventDate: Date?) -> String {
        guard let date = eventDate else { return "???" }
        
        return DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
    }
    
    func getOvertimeLength(duration: Int) -> String {
        let overtime = duration - 300
        let minutes = overtime / 60
        let seconds = overtime % 60
        let secondsString = seconds == 0 ? "00" : "\(seconds)"
        
        return "+\(minutes):" + secondsString
    }
    
    var body: some View {
        ZStack {
            
            Color.secondaryGroupedBackground
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    if game.map != nil {
                        Label(
                            title: {
                                Text(game.map!.name)
                                    .font(.system(.subheadline).weight(.regular))
                                    .foregroundColor(.primary)
                            },
                            icon: {
                                Image(systemName: "map")
                                    .foregroundColor(.red)
                            }
                        )
                        
                    }
                    
                    
                    Label(
                        title: {
                            Text(game.duration > 300 ? getOvertimeLength(duration: game.duration) : "No OT")
                                .font(.system(.subheadline).weight(.regular))
                                .foregroundColor(.primary)
                        },
                        icon: {
                            Image(systemName: "stopwatch")
                                .foregroundColor(.blue)
                        }
                    )
                    
                }
                
                Divider()
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    
                    Label (
                        title: {
                            Text("\(game.match.event.mode)v\(game.match.event.mode)")
                                .font(.system(.subheadline).weight(.regular))
                                .foregroundColor(.primary)
                        },
                        icon: {
                            Image(systemName: "car")
                                .foregroundColor(.purple)
                        }
                    )
                    
                    
                    Label (
                        title: {
                            Text("\(game.match.stage.lan ? "LAN" : "Online")")
                                .font(.system(.subheadline).weight(.regular))
                                .foregroundColor(.primary)
                        },
                        icon: {
                            Image(systemName: "network")
                                .foregroundColor(.gray)
                        }
                    )
                    
//                    Spacer()
                }
                Spacer()
            }
            .padding()
            
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

struct GameResultsHeaderView: View {
    var game: GameResult

    var blueNameSplit: (String, String) {
        splitName(name: game.blue.teamInfo.team.name)
    }

    var orangeNameSplit: (String, String) {
        splitName(name: game.orange.teamInfo.team.name)
    }

    var inProgress: Bool {
        if !game.blue.winner && !game.orange.winner {
            return true
        } else {
            return false
        }
    }

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                NavigationLink(
                    destination: NavigationLazyView(
                        EventDetailView(eventID: game.match.event.slug)
                            .navigationBarTitleDisplayMode(.large)
                    )) {

                    VStack(alignment: .leading) {
                        Text(game.match.event.name)
                            .multilineTextAlignment(.leading)
                            .font(.system(.subheadline).weight(.bold))
                            .foregroundColor(.primary)

                        Text(game.match.stage.name)
                            .font(.system(.subheadline).weight(.regular))
                            .foregroundColor(.primary)

                        if game.date != nil {
                            Text("\(game.date!.dateToLocal(option: .dateTime))")
                                .font(.system(.subheadline).weight(.light))
                                .foregroundColor(.primary)
                            
                        }

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

                    NavigationLink(
                        destination: TeamScreen(team: game.blue.teamInfo.team),
                        label: {
                            UrlImageView(urlString: game.blue.teamInfo.team.image, type: .logo)
                                .frame(width: 100, height: 75, alignment: .center)
                                .padding(.trailing)
                        })

                    Text("\(game.blue.teamInfo.stats?.core.goals ?? 0)")
                        .font(.system(.largeTitle, design: .rounded).weight(game.blue.winner ? .bold : .regular))
                        .foregroundColor(inProgress ? .primary : (game.blue.winner ? .green : .red))

                    Text("-")
                        .font(.system(.title, design: .rounded).weight(.bold))

                    Text("\(game.orange.teamInfo.stats?.core.goals ?? 0)")
                        .font(.system(.largeTitle, design: .rounded).weight(game.orange.winner ? .bold : .regular))
                        .foregroundColor(inProgress ? .primary : (game.orange.winner ? .green : .red))

                    NavigationLink(
                        destination: TeamScreen(team: game.orange.teamInfo.team),
                        label: {
                            UrlImageView(urlString: game.orange.teamInfo.team.image, type: .logo)
                                .frame(width: 100, height: 75, alignment: .center)
                                .padding(.leading)
                        })

                    Spacer()
                }
                .padding(.top)

                // teams names
                HStack {

                    NavigationLink(
                        destination: TeamScreen(team: game.blue.teamInfo.team),
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
                        destination: TeamScreen(team: game.orange.teamInfo.team),
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
            .background(Color.secondaryGroupedBackground)
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

struct GameScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameScreen(gameID: "6082fb4c0d9dcf9da5a4d2ea", gameNumber: "One")
    }
}
