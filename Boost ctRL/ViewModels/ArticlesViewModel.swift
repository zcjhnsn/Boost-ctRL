//
//  ArticlesViewModel.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/14/21.
//

import Foundation
import Combine

class ArticlesViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var shiftArticles: [Article] = [
        Article(title: "RL is Life", articleDescription: "What a save, what a save, what a save!", slug: "", publishedAt: Date(), image: ArticleImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/c/c3/Rocket_League_logo.svg")!), authors: [Author(name: "Slybae", id: "asdf")], id: "asdf")
    ]
    @Published var isShiftLoading: Bool = true
    @Published var isOctaneLoading: Bool = true
    
    var subscriptions = [AnyCancellable]()
    
    init() {
        getShiftArticles()
    }
    
    /// Retrieve articles from https://shiftrle.gg
    private func getShiftArticles() {
        API.getShiftArticles()
            .mapError({ error -> Error in
                print("💀 Error - Could not fetch Shift articles - \(error)")
                
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { articles in
                self.shiftArticles = articles
                self.articles = articles
                self.isShiftLoading = false
            })
            .store(in: &subscriptions)
        
    }
}
