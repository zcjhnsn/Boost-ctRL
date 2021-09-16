//
//  TeamScoreRowSmall.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 6/25/21.
//

import SwiftUI

struct TeamScoreRowSmall: View {
    var teamResult: TeamResult
    var isInProgress: Bool
    
    var scoreColor: Color {
        if isInProgress {
            return .black
        } else if teamResult.winner {
            return .green
        } else {
            return .red
        }
    }
    
    let defaultFontStyle: Font = .system(.footnote, design: .rounded)
                                    .weight(.regular)
    let winnerFontStyle: Font = .system(.footnote, design: .rounded)
                                    .weight(.bold)
    let loserScoreFontStyle: Font = .system(.subheadline, design: .rounded)
                                        .weight(.regular)
    let winnerScoreFontStyle: Font = .system(.subheadline, design: .rounded)
                                        .weight(.bold)
    let inProgressFontStyle: Font = .system(.footnote, design: .rounded)
                                        .weight(.regular)   
    
    var body: some View {
        HStack {
            // MARK: - Image

            UrlImageView(urlString: "\(teamResult.teamInfo.team.image)", type: .logo)
                .frame(width: 20, height: 20, alignment: .top)
                .clipped()
            
            // MARK: - Team Name

            Text(teamResult.teamInfo.team.name)
                .font(teamResult.winner ? winnerFontStyle : defaultFontStyle)
                .foregroundColor(teamResult.winner ? .primary : .secondary)
            
            Spacer()
            
            // MARK: - Score
            
            Text("\(teamResult.score)")
                .frame(alignment: .leading)
                .foregroundColor(scoreColor)
                .font(teamResult.winner ? winnerScoreFontStyle : loserScoreFontStyle)
            
        }
        .padding([.horizontal], 12)
    }
}

struct TeamScoreRowSmall_Previews: PreviewProvider {
    static var previews: some View {
        TeamScoreRowSmall(
            teamResult: PreviewHelper.TEAM_RESULT_NA_1,
            isInProgress: false
        )
    }
}
