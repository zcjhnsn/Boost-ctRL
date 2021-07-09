//
//  NewsAPI.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/14/21.
//

import Foundation
import Combine

enum Endpoint {
    case newsRocketeers
    case newsOctane
    case matches
    
    var path: String {
        switch self {
        case .newsOctane:
            return "/articles"
        case .newsRocketeers:
            return "/wp-json/wp/v2/posts"
        case .matches:
            return "/matches"
        }
    }
}

enum API {
    static let agent = Agent()
    static let octaneBase = URL(string: "https://zsr.octane.gg")!
    static let octaneNewsBase = URL(string: "https://content.octane.gg")!
    static let rocketeersBase = URL(string: "https://rocketeers.gg")!
    
    
    static func run<T: Decodable>(_ request: URLRequest, decodingArticleType: Agent.ArticleSource = .notAnArticle) -> AnyPublisher<T, Error> {
        let decoder: JSONDecoder = JSONDecoder()
        
        switch decodingArticleType {
        case .octaneNews:
            decoder.userInfo[.newsSite] = Article.Site.octane
        case .rocketeersNews:
            decoder.userInfo[.newsSite] = Article.Site.rocketeers
        case .notAnArticle:
            break
        }
        
        return agent.run(request, decoder)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    
    static func getRocketeersArticles() -> AnyPublisher<[Article], Error> {
        var components = URLComponents(string: rocketeersBase.appendingPathComponent(Endpoint.newsRocketeers.path).absoluteString)!
        components.queryItems = [
            URLQueryItem(name: "per_page", value: "10"),
            URLQueryItem(name: "_embed", value: nil)
        ]
        
        let request = URLRequest(url: components.url!)
        return run(request, decodingArticleType: .rocketeersNews)
    }
    
    static func getOctaneArticles() -> AnyPublisher<[Article], Error> {
        var components = URLComponents(string: octaneNewsBase.appendingPathComponent(Endpoint.newsOctane.path).absoluteString)!
        components.queryItems = [
            URLQueryItem(name: "_sort", value: "published_at:desc"),
            URLQueryItem(name: "_limit", value: "10")
        ]
        
        let request = URLRequest(url: components.url!)
        return run(request, decodingArticleType: .octaneNews)
    }
    
    
    /// Retrieves most recent matches
    /// - Parameter limit: number of results (default = 10)
    /// - Returns: MatchResults object
    static func getRecentMatches(limit: Int = 10) -> AnyPublisher<MatchResponse, Error> {
        var components = URLComponents(string: octaneBase.appendingPathComponent(Endpoint.matches.path).absoluteString)!
        components.queryItems = [
            URLQueryItem(name: "group", value: "rlcs"),
            URLQueryItem(name: "sort", value: "date:desc"),
            URLQueryItem(name: "perPage", value: "\(limit)")
        ]
        
        let request = URLRequest(url: components.url!)
        
        return run(request)
    }
}
