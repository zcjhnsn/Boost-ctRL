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
                        
                        UrlImageView(urlString: article.image.url.absoluteString, type: .news)
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
    static var article = try! Article(
        json: """
            {"title": "Shift 16: Ranking the Fall Major teams",
              "description": "The Shift staff ranked the Fall Major teams and talked about how they got here.",
              "published_at": "2022-12-06T18:22:54.732Z",
              "slug": "shift-16-ranking-the-fall-major-teams",
              "image": {
                  "url": "https://octane-content.s3.amazonaws.com/Vatira_Spring_Major_2021_22_Psyonix_ee732addf6.jpg"
              },
              "authors": [{
                  "name": "Travis Messall",
                  "id": "6362f1a2b73aac00195a3cbb"
              }],
              "id": "638ea39cb73aac00195a3cf8"
            }
        """
    )
    static var previews: some View {
        ArticleItemCardView(article: article)
    }
}
