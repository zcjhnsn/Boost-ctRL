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
    @Published var shiftArticles: [Article] = [Article(id: "0", image: "https://upload.wikimedia.org/wikipedia/commons/c/c3/Rocket_League_logo.svg", link: "https://shiftrle.gg", title: "RL is life"), Article(id: "1", image: "https://upload.wikimedia.org/wikipedia/commons/c/c3/Rocket_League_logo.svg", link: "https://shiftrle.gg", title: "What a save, what a save, what a save")]
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
    @Published var isShiftLoading: Bool = true
    @Published var isOctaneLoading: Bool = true
    
    var subscriptions = [AnyCancellable]()
    
    init() {
        getArticles()
    }
    
    private func getArticles() {
        let shift = API.getShiftArticles()
        let octane = API.getOctaneArticles()
        
        Publishers.Zip(shift, octane)
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
                
                self.articles = receivedArticles.sorted { $0.date > $1.date }
                self.isOctaneLoading = false
                self.isShiftLoading = false
            })
            .store(in: &subscriptions)
    }
    
    
    /// If there is an error trying to get articles from a source, try each individually so we at least have something
    private func getSeparate() {
        getShiftArticles()
        getOctaneArticles()
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
                self.isShiftLoading = false
            })
            .store(in: &subscriptions)
        
    }
    
    /// Retrieve articles from https://octane.gg
    private func getOctaneArticles() {
        API.getOctaneArticles()
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
            .store(in: &subscriptions)
    }
}
