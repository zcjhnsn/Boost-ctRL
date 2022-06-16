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
                        Text(article.newsSource == .octane ? "Octane" : "Shift")
                            .font(.system(.footnote).smallCaps())
                    } icon: {
                        Image(article.newsSource == .octane ? "octane-glyph" : "shift-glyph")
                            .frame(width: 10, height: 15, alignment: .center)
                            .imageScale(.large)
                            .padding(.vertical, 8)
                            .padding(.leading, 15)
                    }
                    .foregroundColor(article.newsSource == .octane ? .octaneGreen : .shiftOrange)

                    
                    Spacer()
                }
                .background {
//                    LinearGradient(colors: [.gray, .gray2, .gray3, .gray4, .gray5, .gray6, .secondaryGroupedBackground], startPoint: .leading, endPoint: .center)
//                        .opacity(0.4)
                    switch article.newsSource {
                    case .octane:
                        LinearGradient(colors: [.octaneGreen, .secondaryGroupedBackground], startPoint: .leading, endPoint: .center)
                            .opacity(0.4)
                    case .shift:
                        LinearGradient(colors: [.shiftOrange, .secondaryGroupedBackground], startPoint: .leading, endPoint: .center)
                            .opacity(0.4)
                    }
                        
                }
                
                HStack {
                    Text(article.title)
                        .font(Font.system(.headline))
                        .padding(.leading)
                        .padding(.trailing, 134)
                    
                    Spacer()
                    
                }
                
                if article.description != nil {
                    HStack(alignment: .top) {
                        Text(article.description!)
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
                
                UrlImageView(urlString: article.image, type: .news(.shift))
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
                Text("\(article.date.timeAgo())")
                    .padding(.leading)
                    .padding(.vertical, 6)
                    .font(Font.system(.caption).bold())
                
                if article.author != nil {
                    Text(verbatim: "\u{2022}")
                        .font(Font.system(.caption).bold())
                    
                    Text(article.author!)
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
                            openURL(LinkHelper.processLinkForDestination(article.baseURL, destination: linkDestination))
                        }
                    } label: {
                        Text("Go to \(article.newsSource.rawValue)")
                        Image(article.newsSource == .shift ? "shift-glyph" : "octane-glyph")
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
                SafariView(url: LinkHelper.processLinkForDestination(article.baseURL, destination: linkDestination))
                    .edgesIgnoringSafeArea(.all)
            } else {
                
                SafariView(url: LinkHelper.processLinkForDestination(genericLink ? article.baseURL : article.link, destination: linkDestination))
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
    static var previews: some View {
        ArticleCardView(article: Article(id: "5fb2c33fc2ec7c1910d4d030", image: "https://images.squarespace-cdn.com/content/v1/5fb2c33fc2ec7c1910d4d030/1654815417578-I2WLHSO5PM3TC9E1N69A/SUPER-16-REGIONAL-PREVIEW_Web.png", link: "https://shiftrle.gg/articles/super-16-preview", title: "Super 16 Preview", description: nil, date: Date(timeIntervalSince1970: Double(1654873140465) / 1000.0), author: "Travis Messall"))
            .preferredColorScheme(.light)
        ArticleCardView(article: Article(id: "61f18ff211e0480019db841b", image: "https://octane-content.s3.amazonaws.com/01_monkey_d3116bd68b.jpg", link: "https://octane.gg/news/top-20-players-of-2021-m0nkey-m00n-1", title: "Top 20 Players of 2021: M0nkey M00n (#1)", description: "The catalyst of Team BDS earns the highest honours on our list after an outstanding year of stellar performances.", date: Date(timeIntervalSince1970: Double(1654873140465) / 1000.0), author: "Travis Messall"))
            .preferredColorScheme(.dark)
    }
}
