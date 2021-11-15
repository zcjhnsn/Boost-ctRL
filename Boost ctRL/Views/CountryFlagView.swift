//
//  CountryFlagView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 9/28/21.
//

import SwiftUI

struct CountryFlagView: View {
    var countryAbbreviation: String?
    
    private var countryFlag: UIImage? {
        return UIImage(named: countryAbbreviation!)
    }
    
    var body: some View {
        if countryAbbreviation == nil || countryFlag == nil {
            Image(systemName: "minus.rectangle.fill")
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.gray)
        } else {
            Image(uiImage: countryFlag!)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct CountryFlagView_Previews: PreviewProvider {
    static var previews: some View {
        CountryFlagView(countryAbbreviation: nil)
    }
}
