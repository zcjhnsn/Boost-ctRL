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
            UrlImageView(urlString: article.image.url.absoluteString, type: .news)
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
                     
                        Text(article.articleDescription ?? "")
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
        ArticleItemView(article: article)
    }
}
