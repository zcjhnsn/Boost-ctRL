//
//  ArticleItemView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/9/21.
//

import SwiftUI

struct ArticleItemView: View {
    var article: Article
    
    var body: some View {
                ZStack(alignment: .bottom, content: {
                    UrlImageView(urlString: article.image, type: .news)
                        .clipped()
                        .overlay(
                            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .top, endPoint: .bottom)
                        )
                    
                    HStack {
                        
                        Text(article.title)
                            .lineLimit(3)
                            .font(Font.headline.weight(.bold))
                            .foregroundColor(.white)
                            .padding([.leading, .bottom])
                        
                        Spacer()
                    }
                })
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .shadow(radius: 5)
    }
    
}

struct ArticleItemView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleItemView(article: Article(id: "0", image: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FSmiley&psig=AOvVaw3yRcOU40mPK8Oxs4Fm1w56&ust=1615786137316000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCKjUlciGr-8CFQAAAAAdAAAAABAD", link: "https://google.com", title: "This is a news items with a longer title. Hopfully it fits. \nPerhaps \nNope"))
    }
}
