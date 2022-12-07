//
//  ArticleRowView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/14/21.
//

import SwiftUI

struct ArticleRowView: View {
    var publisherName: String
    var articles: [Article]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(publisherName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(articles) { article in
                        ArticleItemCardView(article: article)
                    }
                }
            }
            .padding(.bottom, 6)
        }
    }
}

struct ArticleRowView_Previews: PreviewProvider {
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
        ArticleRowView(publisherName: "Rocketeers.gg",
                       articles: [article]
        )
    }
}
