//
//  SearchItemView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 6/7/22.
//

import SwiftUI

struct SearchItemView: View {
    var item: SearchItem
    
    var body: some View {
        ZStack {
            HStack {
                Text(getBuffer())
                Text(item.type.rawValue)
                    .padding([.vertical, .leading])
                    .font(.system(.body).smallCaps())
                    .foregroundColor(Color.gray)
                
                if item.type == .player {
                    Text(getCountryFlag())
                        .padding(.vertical)
                        .padding(.horizontal, 6)
                } else {
                    UrlImageView(urlString: item.image, type: .logo)
                        .frame(width: 20, height: 20, alignment: .center)
                        .padding(.vertical)
                        .padding(.horizontal, 6)
                }
                
                Text(item.label)
                    .font(.system(.headline))
                
                Spacer()
            }
        }
        .background(Color.secondaryGroupedBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
    
    func getBuffer() -> String {
        switch item.type {
        case .player:
            return ""
        case .event:
            return " "
        case .team:
            return "  "
        }
    }
    
    func getCountryFlag() -> String {
        guard let code = item.image else { return "🌎" }
        let emojiString = IsoCountries.flag(countryCode: code)
        guard let emoji = emojiString else { return "🌎" }
        return emoji
    }
}

struct SearchItemView_Previews: PreviewProvider {
    static var previews: some View {
        SearchItemView(item: SearchItem(type: .player, id: "asdfjkl", label: "GarrettG", image: "us", groups: nil))
    }
}
