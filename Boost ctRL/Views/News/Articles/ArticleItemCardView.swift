//
//  ArticleItemView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/13/21.
//

import SwiftUI

struct ArticleItemCardView: View {
    var article: Article
    
    var body: some View {
    
            VStack(alignment: .leading) {
                GeometryReader { geo in
                    VStack(alignment: .leading, spacing: 8, content: {
                        
                        UrlImageView(urlString: article.image, type: .news(.octane))
                            .frame(width: geo.size.width, height: geo.size.height * 0.6, alignment: .top)
                            .clipped()
                        
                        Text(article.title)
                            .lineLimit(3)
                            .frame(width: geo.size.width * 0.95, height: geo.size.height * 0.3, alignment: .topLeading)
                            .padding([.leading, .trailing], 6)
                            .font(Font.headline.weight(.bold))
                    })
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .top)
                }
            }
            .background(Color(UIColor.systemGray5))
            .frame(width: 242, height: 223, alignment: .topLeading)
            .cornerRadius(8, corners: .allCorners)
            .padding(.leading, 15)
            
            
        }
    
}

struct ArticleItemCardView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleItemCardView(article: Article(id: "0", image: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FSmiley&psig=AOvVaw3yRcOU40mPK8Oxs4Fm1w56&ust=1615786137316000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCKjUlciGr-8CFQAAAAAdAAAAABAD", link: "https://google.com", title: "This is a news items with a longer title. Hopfully it fits. \nPerhaps \nNope"))
    }
}
