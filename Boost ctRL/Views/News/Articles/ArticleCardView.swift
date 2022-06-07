//
//  ArticleCardView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 6/2/22.
//

import SwiftUI

struct ArticleCardView: View {
    var body: some View {
        VStack(spacing: 0) {
            ArticleCard()
            
            Divider()
            
            ArticleCardMetaDataView()
        }
        .frame(height: 180, alignment: .center)
        .background(Color.ctrlBlue.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

struct ArticleCard: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image("shift-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 15, alignment: .center)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 28)
                    
                    Spacer()
                }
                .background(.thinMaterial)
                .mask {
                    LinearGradient(colors: [.white.opacity(0.8), .white.opacity(0.7), .white.opacity(0.3), .clear], startPoint: .leading, endPoint: .trailing)
                }
                
                HStack {
                    Text("This is an article title where we talk about something cool")
                        .font(Font.system(.headline))
                        .padding(.leading)
                        .padding(.trailing, 134)
                    
                    Spacer()
                    
                }
                
                Spacer()
                
            }
            
            HStack {
                Spacer()
                
                Rectangle()
                    .foregroundColor(.red)
                    .frame(width: 120, height: 120, alignment: .trailing)
                    .background(
                        Color.red
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .padding(.horizontal)
            }
        }
        
    }
}

struct ArticleCardMetaDataView: View {
    var body: some View {
        HStack {
            HStack {
                Text("3h ago")
                    .padding(.leading)
                    .padding(.vertical, 6)
                    .font(Font.system(.caption).bold())
                
                Text(verbatim: "\u{2022}")
                    .font(Font.system(.caption).bold())
                    
                Text("Achilles")
                    .font(Font.system(.caption).bold())
                
                Spacer()
            }
            .foregroundColor(.secondary)
            
            
            Spacer()
            
            Button {
                // action
            } label: {
                Image(systemName: "ellipsis")
                    .tint(.secondary)
            }
            .padding(.horizontal)
        }
    }
}

struct ArticleCardView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleCardView()
            .preferredColorScheme(.light)
        ArticleCardView()
            .preferredColorScheme(.dark)
    }
}
