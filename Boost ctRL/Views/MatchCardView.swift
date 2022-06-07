//
//  MatchCardViewSmall.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 6/23/21.
//

import SwiftUI

enum ViewSize {
    case small
    case medium
    case large
}

struct MatchCardView: View {
    var match: Match
    var viewSize: ViewSize
    var inProgress: Bool {
        if !match.blue.winner && !match.orange.winner {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        if viewSize == .small {
            NavigationLink(
                destination: MatchResultView(match: match)
                                .navigationTitle("Match Overview")
            ) {
                
                VStack(alignment: .leading) {
                    GeometryReader { geo in
                        VStack(alignment: .leading, spacing: 8, content: {
                            
                            HStack {
                                
                                VStack(spacing: 6) {
                                    
                                    Text(match.event.name)
                                        .font(.system(.footnote, design: .rounded))
                                        .padding([.horizontal, .top], 12)
                                        .frame(width: 220, alignment: .leading)
                                    
                                    TeamScoreRow(teamResult: match.blue, isInProgress: inProgress, viewSize: viewSize)
                                    
                                    
                                    TeamScoreRow(teamResult: match.orange, isInProgress: inProgress, viewSize: viewSize)
                                        .padding([.bottom], 12)
                                }
                            }
                            
                        })
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .top)
                        
                    }
                }
                .background(Color.secondaryGroupedBackground)
                .frame(width: 220, height: 90, alignment: .topLeading)
                .cornerRadius(8, corners: .allCorners)
                .padding(.leading, 15)
                .padding(.vertical, 4)
            }
        } else {
            NavigationLink(
                destination: MatchResultView(match: match)
                                .navigationTitle("Match Overview")
            ) {
                
                VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 8, content: {
                            
                            HStack {
                                
                                
                                VStack(spacing: 6) {
                                    HStack {
                                        Text(match.date.dateToLocal(option: .time))
                                            .font(.system(.footnote, design: .rounded))
                                        
                                        Spacer()
                                        
                                        Text(match.stage.name)
                                            .font(.system(.footnote, design: .rounded))
                                        
                                    }
                                    .padding([.horizontal, .top], 12)
                                    
                                    TeamScoreRow(teamResult: match.blue, isInProgress: inProgress, viewSize: viewSize)
                                    
                                    
                                    TeamScoreRow(teamResult: match.orange, isInProgress: inProgress, viewSize: viewSize)
                                        .padding([.bottom], 12)
                                }
                            }
                            
                        })
                        
                }
                .background(Color(UIColor.secondarySystemGroupedBackground))
                .cornerRadius(8, corners: .allCorners)
                .padding(.horizontal)
                .padding(.vertical, 4)
            }
        }
        
    }
}

struct MatchCardView_Previews: PreviewProvider {
    static var previews: some View {
        MatchCardView(match: ExampleData.match, viewSize: .medium)
            .preferredColorScheme(.light)
        MatchCardView(match: ExampleData.match, viewSize: .medium)
            .preferredColorScheme(.dark)
        
    }
}
