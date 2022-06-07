//
//  RecentResultsRowView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/1/21.
//

import SwiftUI

struct RecentResultsRowView: View {
    var recentMatches: [Match]
    
    var body: some View {

        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(recentMatches) { m in
                        MatchCardView(match: m, viewSize: .small)
                    }
                }
            }
            .padding(.bottom, 6)
        }
    }
}

struct RecentResultsRowView_Previews: PreviewProvider {
    static var previews: some View {
        RecentResultsRowView(recentMatches: [
            ExampleData.match
        ])
    }
}
