//
//  ErrorScreen.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/29/22.
//

import SwiftUI

enum ScreenType {
    case game
    case player
    case team
    case match
    case event
}

struct ErrorScreen: View {
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Text("Oops!")
                    .font(Font.largeTitle)
                
                Text("We couldn't find anything for that request. Octane.gg may not have that data yet. Check again later!")
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
        .navigationTitle("Sorry!")
    }
}

struct ErrorScreen_Previews: PreviewProvider {
    static var previews: some View {
        ErrorScreen()
    }
}
