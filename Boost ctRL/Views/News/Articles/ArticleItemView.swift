//
//  ArticleItemView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/9/21.
//

import SwiftUI

struct ArticleItemView: View {
    @Environment(\.openURL) var openURL
    @AppStorage("LinkDestination") var linkDestination = 0
    @State var openInAppBrowser = false
    
    var article: Article
    
    var body: some View {
        ZStack(alignment: .bottom, content: {
            UrlImageView(urlString: article.image, type: .news(.octane))
                .clipped()
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
                        .onTapGesture {
                            if linkDestination == 0 {
                                openInAppBrowser = true
                            } else {
                                openURL(LinkHelper.processLinkForDestination(article.link, destination: linkDestination))
                            }
                        }
                 )
            
            HStack {
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(article.title)
                            .lineLimit(3)
                            .font(Font.headline.weight(.heavy))
                            .foregroundColor(.white)
                     
                        Text(article.description ?? "")
                            .lineLimit(3)
                            .font(Font.subheadline.weight(.regular))
                            .foregroundColor(.white)
                    }
                        .padding([.leading, .bottom], 10)
                    
                    Divider()
                    
                    ArticleCardMetaDataView(article: article)
                        .foregroundColor(.white)
                }
                
                
                Spacer()
            }
            .allowsHitTesting(false)
        })
        .cornerRadius(8)
        .sheet(isPresented: $openInAppBrowser, content: {
            SafariView(url: LinkHelper.processLinkForDestination(article.link, destination: linkDestination))
                .edgesIgnoringSafeArea(.all)
                
        })
    }
}

struct ArticleItemView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleItemView(article: Article(id: "0", image: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FSmiley&psig=AOvVaw3yRcOU40mPK8Oxs4Fm1w56&ust=1615786137316000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCKjUlciGr-8CFQAAAAAdAAAAABAD", link: "https://google.com", title: "This is a news items with a longer title. Hopfully it fits. \nPerhaps \nNope", description: "Tap on this image to read more about this article."))
    }
}
