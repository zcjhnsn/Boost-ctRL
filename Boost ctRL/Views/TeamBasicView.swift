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
            return .teal
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
        
        NavigationLink(destination: TeamScreen(team: Team(id: team.team.id, slug: team.team.slug, name: team.team.name, image: team.team.image ?? "", region: team.team.region?.rawValue ?? "INT"))) {
            
            HStack {
                UrlImageView(urlString: team.team.image, type: .logo)
                    .padding(4)
                    .background(Color.secondaryGroupedBackground)
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
        TeamBasicView(team: ExampleData.activeTeam)
    }
}
