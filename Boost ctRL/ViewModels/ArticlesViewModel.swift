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
    @Published var rocketeersArticles: [Article] = []
    @Published var octaneArticles: [Article] = []
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
                print("❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️ - \(error)")
                self.getSeparate()
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { rArticles, oArticles in
                    var receivedArticles = [Article]()
                    
                    receivedArticles.append(contentsOf: rArticles)
                    
                    receivedArticles.append(contentsOf: oArticles)
                      
                    self.articles = receivedArticles
                  })
    }
    
    private func getSeparate() {
        getRocketeersArticles()
        getOctaneArticles()
    }
    
    private func getRocketeersArticles() {
        rocketeersCancellationToken = API.getRocketeersArticles()
            .mapError({ error -> Error in
                print("💙💙💙💙💙💙💙💙💙💙 - \(error)")
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { articles in
                    
                    print("💜💜💜💜💜💜💜💜💜💜 - \(articles)")
                    self.rocketeersArticles = articles
                    self.isRocketeersLoading = false
                  })
            
    }
    
    private func getOctaneArticles() {
        octaneCancellationToken = API.getOctaneArticles()
            .mapError({ error -> Error in
                print("💚💚💚💚💚💚💚💚💚💚 - \(error)")
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { articles in
                    
                    self.octaneArticles = articles
                    self.isOctaneLoading = false
                  })
    }
}
