//
//  ArticleCardView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 6/2/22.
//

import SwiftUI

struct ArticleCardView: View {
    let article: Article
    
    var body: some View {
        VStack(spacing: 0) {
            ArticleCard(article: article)
            
            Divider()
            
            ArticleCardMetaDataView(article: article)
                .foregroundColor(.secondary)
        }
        .frame(height: 180, alignment: .center)
        .background(Color.secondaryGroupedBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

struct ArticleCard: View {
    @Environment(\.openURL) var openURL
    @AppStorage("LinkDestination") var linkDestination = 0
    @State var openInAppBrowser = false
    
    let article: Article
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Label {
                        Text("Shift")
                            .font(.system(.footnote).smallCaps())
                    } icon: {
                        Image("shift-glyph")
                            .frame(width: 10, height: 15, alignment: .center)
                            .imageScale(.large)
                            .padding(.vertical, 8)
                            .padding(.leading, 15)
                    }
                    .foregroundColor(.shiftOrange)

                    
                    Spacer()
                }
                .background {
                    LinearGradient(colors: [.shiftOrange, .secondaryGroupedBackground], startPoint: .leading, endPoint: .center)
                        .opacity(0.4)
                }
                
                HStack {
                    Text(article.title)
                        .font(Font.system(.headline))
                        .padding(.leading)
                        .padding(.trailing, 134)
                    
                    Spacer()
                    
                }
                
                if !article.articleDescription.isEmpty {
                    HStack(alignment: .top) {
                        Text(article.articleDescription)
                            .font(Font.system(.subheadline))
                            .frame(alignment: .topLeading)
                            .padding(.leading)
                            .padding(.top, 2)
                            .padding(.trailing, 134)
                        
                        Spacer()
                    }
                }
                
                Spacer()
                
            }
            
            HStack {
                Spacer()
                
                UrlImageView(urlString: article.image.url.absoluteString, type: .news)
                    .frame(width: 120, height: 120, alignment: .center)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .padding(.horizontal)
            }
        }
        .onTapGesture {
            if linkDestination == 0 {
                openInAppBrowser = true
            } else {
                openURL(LinkHelper.processLinkForDestination(article.link, destination: linkDestination))
            }
        }
        .sheet(isPresented: $openInAppBrowser, content: {
            SafariView(url: LinkHelper.processLinkForDestination(article.link, destination: linkDestination))
                .edgesIgnoringSafeArea(.all)
                
        })
        
    }
}

struct ArticleCardMetaDataView: View {
    @Environment(\.openURL) var openURL
    @AppStorage("LinkDestination") var linkDestination = 0
    @State var openInAppBrowser = false
    @State var genericLink = false
    
    let article: Article
    
    var body: some View {
        HStack {
            HStack {
                Text("\(article.publishedAt.timeAgo())")
                    .padding(.leading)
                    .padding(.vertical, 6)
                    .font(Font.system(.caption).bold())
                
                if !article.authors.isEmpty {
                    Text(verbatim: "\u{2022}")
                        .font(Font.system(.caption).bold())
                    
                    Text(String(article.authors.map { $0.name }.joined(separator: ", ")))
                        .font(Font.system(.caption).bold())
                }
                
                Spacer()
            }
            
            
            Spacer()
            
            Menu {
                Section {
                    Button {
                        UIPasteboard.general.string = article.link
                    } label: {
                        Text("Copy link")
                        Image(systemName: "doc.on.doc")
                    }
                    
                    Button {
                        actionSheet(article: article)
                    } label: {
                        Label("Share link", systemImage: "square.and.arrow.up")
                    }
                }
                
                Section {
                    Button {
                        genericLink = true
                        if linkDestination == 0 {
                            openInAppBrowser = true
                        } else {
                            openURL(LinkHelper.processLinkForDestination("https://shiftRLE.gg", destination: linkDestination))
                        }
                    } label: {
                        Text("Go to ShiftRLE")
                        Image("shift-glyph")
                            .imageScale(.large)
                    }
                }
                

            } label: {
                Image(systemName: "ellipsis")
                    .renderingMode(.template)
                    .padding(.horizontal)
                    .padding(.vertical, 6)
            }
                
        }
        .sheet(isPresented: $openInAppBrowser, onDismiss: {
            openInAppBrowser = false
            genericLink = false
        }, content: {
            if genericLink {
                SafariView(url: LinkHelper.processLinkForDestination("https://shiftRLE.gg", destination: linkDestination))
                    .edgesIgnoringSafeArea(.all)
            } else {
                SafariView(url: LinkHelper.processLinkForDestination(genericLink ? "https://shiftRLE.gg" : article.link, destination: linkDestination))
                    .edgesIgnoringSafeArea(.all)
            }
                
        })
    }
    
    func actionSheet(article: Article) {
        guard let urlShare = URL(string: article.link) else { return }
        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
}

struct ArticleCardView_Previews: PreviewProvider {
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
        ArticleCardView(article: article)
            .preferredColorScheme(.light)
        ArticleCardView(article: article)
            .preferredColorScheme(.dark)
    }
}
