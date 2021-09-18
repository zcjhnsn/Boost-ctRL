//
//  TeamBasicView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 9/17/21.
//

import SwiftUI

struct TeamBasicView: View {
    let team: ActiveTeam
    
    var regionColor: Color {
        switch team.team.region {
        case .asia:
            return .pink
        case .eu:
            return .blue
        case .me:
            return .orange
        case .na:
            return .red
        case .oce:
            return .purple
        case .sam:
            return .green
        default:
            return .gray
        
        }
    }
    
    var body: some View {
        
        NavigationLink(destination: TeamDetailView(teamID: team.team.id).navigationTitle(Text("Team Detail"))) {
            
            HStack {
                UrlImageView(urlString: team.team.image, type: .logo)
                    .padding(4)
                    .background(Color(UIColor.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                    .frame(width: 50, height: 50, alignment: .center)
                    .padding([.leading])
                
                Text(team.team.name)
                    .font(.system(.title3, design: .default).weight(.semibold))
                    .foregroundColor(.primary)
                    
                Spacer()
                
                HStack {
                    Text("\(team.team.region?.rawValue.uppercased() ?? "?")")
                        .font(.system(.subheadline, design: .default).weight(.medium))
                        .foregroundColor(regionColor)
                        .padding(3)
                }
                .padding([.trailing])
            }
        }
    }
}

struct TeamBasicView_Previews: PreviewProvider {
    static var previews: some View {
        TeamBasicView(team: PreviewHelper.MOCK_ACTIVE_TEAM)
    }
}
