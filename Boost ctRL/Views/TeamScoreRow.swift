//
//  TeamScoreRowSmall.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 6/25/21.
//

import SwiftUI

struct TeamScoreRow: View {
    var teamResult: TeamResult
    var isInProgress: Bool
    var viewSize: ViewSize
    
    private var scoreColor: Color {
        if isInProgress {
            return Color.primary
        } else if teamResult.winner {
            return .green
        } else {
            return .red
        }
    }
    
    private var imageDimension: Double {
        if viewSize == .small {
            return 20
        } else {
            return 40
        }
    }
    
    private var defaultFontStyle: Font {
        if viewSize == .small {
            return .system(.footnote, design: .rounded)
                        .weight(.regular)
        } else {
            return .system(.subheadline, design: .default)
                        .weight(.regular)
        }
    }
        
    private var winnerFontStyle: Font {
        if viewSize == .small {
            return .system(.footnote, design: .rounded)
                        .weight(.bold)
        } else {
            return .system(.subheadline, design: .default)
                        .weight(.bold)
        }
    }
    
    private var loserScoreFontStyle: Font {
        if viewSize == .small {
            return .system(.subheadline, design: .rounded)
                        .weight(.regular)
        } else {
            return .system(.headline, design: .default)
                        .weight(.regular)
        }
    }
    
    private var winnerScoreFontStyle: Font {
        if viewSize == .small {
            return .system(.subheadline, design: .rounded)
                        .weight(.bold)
        } else {
            return .system(.headline, design: .default)
                        .weight(.bold)
        }
    }
    
    private var inProgressFontStyle: Font {
        if viewSize == .small {
            return .system(.footnote, design: .rounded)
                        .weight(.regular)
        } else {
            return .system(.subheadline, design: .default)
                .weight(.regular)
        }
    }
    
    var body: some View {
        HStack {
            // MARK: - Image

            UrlImageView(urlString: "\(teamResult.teamInfo.team.image)", type: .logo)
                .frame(width: imageDimension, height: imageDimension, alignment: .top)
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

struct TeamScoreRow_Previews: PreviewProvider {
    static var previews: some View {
        TeamScoreRow(
            teamResult: ExampleData.teamResult,
            isInProgress: false,
            viewSize: .medium
        )
    }
}
