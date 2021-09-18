//
//  TeamDetailView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 9/17/21.
//

import SwiftUI

struct TeamDetailView: View {
    var teamID: String
    
    var body: some View {
        Text(teamID)
    }
}

struct TeamDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailView(teamID: "6020bc70f1e4807cc70023a0")
    }
}
