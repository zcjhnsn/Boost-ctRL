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
    @Published var rocketeersArticles: [Article] = [Article(id: "0", image: "https://upload.wikimedia.org/wikipedia/commons/c/c3/Rocket_League_logo.svg", link: "https://rocketeers.gg", title: "RL is life"), Article(id: "1", image: "https://upload.wikimedia.org/wikipedia/commons/c/c3/Rocket_League_logo.svg", link: "https://rocketeers.gg", title: "What a save, what a save, what a save")]
    @Published var octaneArticles: [Article] = [
        Article(id: "0", image: "https://upload.wikimedia.org/wikipedia/commons/c/c3/Rocket_League_logo.svg", link: "https://octane.gg", title: "RL is life"),
        Article(id: "1", image: "https://upload.wikimedia.org/wikipedia/commons/c/c3/Rocket_League_logo.svg", link: "https://octane.gg", title: "What a save, what a save, what a save"),
        Article(id: "2", image: "https://upload.wikimedia.org/wikipedia/commons/c/c3/Rocket_League_logo.svg", link: "https://octane.gg", title: "What a save, what a save, what a save"),
        Article(id: "3", image: "https://upload.wikimedia.org/wikipedia/commons/c/c3/Rocket_League_logo.svg", link: "https://octane.gg", title: "What a save, what a save, what a save"),
        Article(id: "4", image: "https://upload.wikimedia.org/wikipedia/commons/c/c3/Rocket_League_logo.svg", link: "https://octane.gg", title: "What a save, what a save, what a save"),
        Article(id: "5", image: "https://upload.wikimedia.org/wikipedia/commons/c/c3/Rocket_League_logo.svg", link: "https://octane.gg", title: "What a save, what a save, what a save"),
        Article(id: "6", image: "https://upload.wikimedia.org/wikipedia/commons/c/c3/Rocket_League_logo.svg", link: "https://octane.gg", title: "What a save, what a save, what a save"),
        Article(id: "7", image: "https://upload.wikimedia.org/wikipedia/commons/c/c3/Rocket_League_logo.svg", link: "https://octane.gg", title: "What a save, what a save, what a save"),
        Article(id: "8", image: "https://upload.wikimedia.org/wikipedia/commons/c/c3/Rocket_League_logo.svg", link: "https://octane.gg", title: "What a save, what a save, what a save")]
    @Published var isRocketeersLoading: Bool = true
    @Published var isOctaneLoading: Bool = true
    
    var cancellationToken: AnyCancellable?
    var octaneCancellationToken: AnyCancellable?
    var rocketeersCancellationToken: AnyCancellable?
    
    init() {
//        getArticles()
        getOctaneArticles()
        getRocketeersArticles()
    }
    
    private func getArticles() {
        let rocketeers = API.getRocketeersArticles()
        let octane = API.getOctaneArticles()
        cancellationToken = Publishers.Zip(rocketeers, octane)
            .mapError({ error -> Error in
                print("💀 Error - Could not fetch articles together, will attempt separate fetch")
                self.getSeparate()
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { rArticles, oArticles in
                    var receivedArticles = [Article]()
                    
                    receivedArticles.append(contentsOf: rArticles)
                    
                    receivedArticles.append(contentsOf: oArticles)
                      
                    self.articles = receivedArticles
                    self.isOctaneLoading = false
                    self.isRocketeersLoading = false
                  })
    }
    
    
    /// If there is an error trying to get articles from a source, try each individually so we at least have something
    private func getSeparate() {
        getRocketeersArticles()
        getOctaneArticles()
    }
    
    /// Retrieve articles from https://rocketeers.gg
    private func getRocketeersArticles() {
        rocketeersCancellationToken = API.getRocketeersArticles()
            .mapError({ error -> Error in
                print("💀 Error - Could not fetch Rocketeers articles")
                
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { articles in
                    self.rocketeersArticles = articles
                    self.isRocketeersLoading = false
                  })
            
    }
    
    /// Retrieve articles from https://octane.gg
    private func getOctaneArticles() {
        octaneCancellationToken = API.getOctaneArticles()
            .mapError({ error -> Error in
                print("💀 Error fetching Octane articles - \(error)")
                
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { articles in
                    self.octaneArticles.removeAll()
                    self.octaneArticles = articles
                    self.isOctaneLoading = false
                  })
    }
}


