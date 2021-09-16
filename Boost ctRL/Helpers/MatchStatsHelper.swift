//
//  MatchStatsHelper.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 8/1/21.
//

import SwiftUI
import SwiftUICharts

enum TeamColor {
    case blue
    case orange
}

struct MatchStatsHelper {
    var match: Match
    
    private var blueTeamLegend: Legend {
        return Legend(
            color: .blue,
            label: LocalizedStringKey(stringLiteral: "\(match.blue.teamInfo.team.name)"),
            order: 0
        )
    }
    
    private var orangeTeamLegend: Legend {
        return Legend(
            color: .orange,
            label: LocalizedStringKey(stringLiteral: "\(match.orange.teamInfo.team.name)"),
            order: 1
        )
    }
    
    private func generateLegend(teamColor: TeamColor, label: String) -> Legend {
        return Legend(
            color: teamColor == .blue ? .blue : .orange,
            label: LocalizedStringKey(stringLiteral: "\(label)"),
            order: teamColor == .blue ? 1 : 2
        )
    }
    
    func getTeamNames() -> [DataPoint] {
        return [
            DataPoint(value: 0, label: LocalizedStringKey(stringLiteral: "Blue Team Name"), legend: blueTeamLegend),
            DataPoint(value: 0, label: LocalizedStringKey(stringLiteral: "Orange Team Name"), legend: orangeTeamLegend)
        ]
    }
    
    func getTeamGoals() -> [DataPoint] {
        guard let blueStats = match.blue.teamInfo.stats, let orangeStats = match.orange.teamInfo.stats else { return [] }
        
        var points = [DataPoint]()
        
        points.append(DataPoint(value: Double(blueStats.core.goals),
                                label: LocalizedStringKey(stringLiteral: "\(Double(match.blue.teamInfo.stats?.core.goals ?? 0))"),
                                legend: blueTeamLegend
        ))
                
        points.append(DataPoint(value: Double(orangeStats.core.goals),
                                label: LocalizedStringKey(stringLiteral: "\(Double(match.orange.teamInfo.stats?.core.goals ?? 0))"),
                                legend: orangeTeamLegend
        ))
        
        return points
    }
    
    func getTeamScore() -> [DataPoint] {
        guard let blueStats = match.blue.teamInfo.stats, let orangeStats = match.orange.teamInfo.stats else { return [] }
        
        var points = [DataPoint]()
        
        points.append(DataPoint(value: Double(blueStats.core.score),
                                label: LocalizedStringKey(stringLiteral: "\(Double(match.blue.teamInfo.stats?.core.score ?? 0))"),
                                legend: blueTeamLegend
        ))
                
        points.append(DataPoint(value: Double(orangeStats.core.score),
                                label: LocalizedStringKey(stringLiteral: "\(Double(match.orange.teamInfo.stats?.core.score ?? 0))"),
                                legend: orangeTeamLegend
        ))
        
        return points
    }
    
    func getTeamAssists() -> [DataPoint] {
        guard let blueStats = match.blue.teamInfo.stats, let orangeStats = match.orange.teamInfo.stats else { return [] }
        
        var points = [DataPoint]()
        
        points.append(DataPoint(value: Double(blueStats.core.assists),
                                label: LocalizedStringKey(stringLiteral: "\(Double(blueStats.core.assists))"),
                                legend: blueTeamLegend
        ))
                
        points.append(DataPoint(value: Double(orangeStats.core.assists),
                                label: LocalizedStringKey(stringLiteral: "\(Double(orangeStats.core.assists))"),
                                legend: orangeTeamLegend
        ))
        
        return points
    }
    
    func getTeamShots() -> [DataPoint] {
        guard let blueStats = match.blue.teamInfo.stats, let orangeStats = match.orange.teamInfo.stats else { return [] }
        
        var points = [DataPoint]()
        
        points.append(DataPoint(value: Double(blueStats.core.shots),
                                label: LocalizedStringKey(stringLiteral: "\(Double(blueStats.core.shots))"),
                                legend: blueTeamLegend
        ))
                
        points.append(DataPoint(value: Double(orangeStats.core.shots),
                                label: LocalizedStringKey(stringLiteral: "\(Double(orangeStats.core.shots))"),
                                legend: orangeTeamLegend
        ))
        
        return points
    }
    
    func getTeamShotPercentage() -> [DataPoint] {
        guard let blueStats = match.blue.teamInfo.stats, let orangeStats = match.orange.teamInfo.stats else { return [] }
        
        var points = [DataPoint]()
        
        points.append(DataPoint(value: Double(blueStats.core.shootingPercentage),
                                label: LocalizedStringKey(stringLiteral: "\(Double(blueStats.core.shootingPercentage))"),
                                legend: blueTeamLegend
        ))
                
        points.append(DataPoint(value: Double(orangeStats.core.shootingPercentage),
                                label: LocalizedStringKey(stringLiteral: "\(Double(orangeStats.core.shootingPercentage))"),
                                legend: orangeTeamLegend
        ))
        
        return points
    }
    
    func getTeamSaves() -> [DataPoint] {
        guard let blueStats = match.blue.teamInfo.stats, let orangeStats = match.orange.teamInfo.stats else { return [] }
        
        var points = [DataPoint]()
        
        points.append(DataPoint(value: Double(blueStats.core.saves),
                                label: LocalizedStringKey(stringLiteral: "\(Double(blueStats.core.saves))"),
                                legend: blueTeamLegend
        ))
                
        points.append(DataPoint(value: Double(orangeStats.core.saves),
                                label: LocalizedStringKey(stringLiteral: "\(Double(orangeStats.core.saves))"),
                                legend: orangeTeamLegend
        ))
        
        return points
    }
    
    func getPlayerNames() -> [DataPoint] {
        let blue = match.blue.players.map { DataPoint(value: 0, label: LocalizedStringKey(stringLiteral: "\($0.player.tag)"), legend: blueTeamLegend) }
                
        let orange = match.orange.players.map { DataPoint(value: 0, label: LocalizedStringKey(stringLiteral: "\($0.player.tag)"), legend: orangeTeamLegend) }
        
        return blue + orange
    }
    
    func getPlayerScore() -> [DataPoint] {
        let blue = match.blue.players.compactMap { DataPoint(value: Double($0.stats?.core.score ?? 0), label: LocalizedStringKey(stringLiteral: "\(Double($0.stats?.core.score ?? 0))"), legend: generateLegend(teamColor: .blue, label: "\($0.player.tag)")) }
        
        let orange = match.orange.players.compactMap { DataPoint(value: Double($0.stats?.core.score ?? 0), label: LocalizedStringKey(stringLiteral: "\(Double($0.stats?.core.score ?? 0))"), legend: generateLegend(teamColor: .orange, label: "\($0.player.tag)")) }
        
        return blue + orange
    }
    
    func getPlayerGoals() -> [DataPoint] {
        let blue = match.blue.players.compactMap { DataPoint(value: Double($0.stats?.core.goals ?? 0), label: LocalizedStringKey(stringLiteral: "\(Double($0.stats?.core.goals ?? 0))"), legend: generateLegend(teamColor: .blue, label: "\($0.player.tag)")) }
        
        let orange = match.orange.players.compactMap { DataPoint(value: Double($0.stats?.core.goals ?? 0), label: LocalizedStringKey(stringLiteral: "\(Double($0.stats?.core.goals ?? 0))"), legend: generateLegend(teamColor: .orange, label: "\($0.player.tag)")) }
        
        return blue + orange
    }
    
    func getPlayerAssists() -> [DataPoint] {
        let blue = match.blue.players.compactMap { DataPoint(value: Double($0.stats?.core.assists ?? 0), label: LocalizedStringKey(stringLiteral: "\(Double($0.stats?.core.assists ?? 0))"), legend: generateLegend(teamColor: .blue, label: "\($0.player.tag)")) }
        
        let orange = match.orange.players.compactMap { DataPoint(value: Double($0.stats?.core.assists ?? 0), label: LocalizedStringKey(stringLiteral: "\(Double($0.stats?.core.assists ?? 0))"), legend: generateLegend(teamColor: .orange, label: "\($0.player.tag)")) }
        
        return blue + orange
    }
    
    func getPlayerSaves() -> [DataPoint] {
        let blue = match.blue.players.compactMap { DataPoint(value: Double($0.stats?.core.saves ?? 0), label: LocalizedStringKey(stringLiteral: "\(Double($0.stats?.core.saves ?? 0))"), legend: generateLegend(teamColor: .blue, label: "\($0.player.tag)")) }
        
        let orange = match.orange.players.compactMap { DataPoint(value: Double($0.stats?.core.saves ?? 0), label: LocalizedStringKey(stringLiteral: "\(Double($0.stats?.core.saves ?? 0))"), legend: generateLegend(teamColor: .orange, label: "\($0.player.tag)")) }
        
        return blue + orange
    }
    
    func getPlayerShots() -> [DataPoint] {
        let blue = match.blue.players.compactMap { DataPoint(value: Double($0.stats?.core.shots ?? 0), label: LocalizedStringKey(stringLiteral: "\(Double($0.stats?.core.shots ?? 0))"), legend: generateLegend(teamColor: .blue, label: "\($0.player.tag)")) }
        
        let orange = match.orange.players.compactMap { DataPoint(value: Double($0.stats?.core.shots ?? 0), label: LocalizedStringKey(stringLiteral: "\(Double($0.stats?.core.shots ?? 0))"), legend: generateLegend(teamColor: .orange, label: "\($0.player.tag)")) }
        
        return blue + orange
    }
    
    func getPlayerShotPercentage() -> [DataPoint] {
        let blue = match.blue.players.compactMap { DataPoint(value: Double($0.stats?.core.shootingPercentage ?? 0), label: LocalizedStringKey(stringLiteral: "\(Double($0.stats?.core.shootingPercentage ?? 0))"), legend: generateLegend(teamColor: .blue, label: "\($0.player.tag)")) }
        
        let orange = match.orange.players.compactMap { DataPoint(value: Double($0.stats?.core.shootingPercentage ?? 0), label: LocalizedStringKey(stringLiteral: "\(Double($0.stats?.core.shootingPercentage ?? 0))"), legend: generateLegend(teamColor: .orange, label: "\($0.player.tag)")) }
        
        return blue + orange
    }

}

extension Double {
    private static var valueFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        return formatter
    }()
    
    var formattedValue: String {
        let number = NSNumber(value: self)
        return Self.valueFormatter.string(from: number)!
    }
    
    var percentage: String {
        "\(formattedValue)%"
    }
}
