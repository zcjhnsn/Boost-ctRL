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
    static var previews: some View {
        ArticleRowView(publisherName: "Rocketeers.gg",
                       articles: [Article(id: "0", image: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FSmiley&psig=AOvVaw3yRcOU40mPK8Oxs4Fm1w56&ust=1615786137316000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCKjUlciGr-8CFQAAAAAdAAAAABAD", link: "https://google.com", title: "Article 1 is really good,Article 1 is really good,Article 1 is really good,Article 1 is really good,Article 1 is really good,Article 1 is really good"), Article(id: "1", image: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FSmiley&psig=AOvVaw3yRcOU40mPK8Oxs4Fm1w56&ust=1615786137316000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCKjUlciGr-8CFQAAAAAdAAAAABAD", link: "https://google.com", title: "Article 2 is really good"), Article(id: "2", image: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FSmiley&psig=AOvVaw3yRcOU40mPK8Oxs4Fm1w56&ust=1615786137316000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCKjUlciGr-8CFQAAAAAdAAAAABAD", link: "https://google.com", title: "Article 3 is really good"), Article(id: "3", image: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FSmiley&psig=AOvVaw3yRcOU40mPK8Oxs4Fm1w56&ust=1615786137316000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCKjUlciGr-8CFQAAAAAdAAAAABAD", link: "https://google.com", title: "Article 4 is really good")]
        )
    }
}
