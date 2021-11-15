//
//  NewsAPI.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/14/21.
//

import Foundation
import Combine

enum Endpoint {
    case activeTeams
    case newsRocketeers
    case newsOctane
    case matches
    case event(id: String)
    case eventParticipants(id: String)
    case eventMatches(id: String)
    case statsForPlayers
    
    var path: String {
        switch self {
        case .activeTeams:
            return "/teams/active"
        case .newsOctane:
            return "/articles"
        case .newsRocketeers:
            return "/wp-json/wp/v2/posts"
        case .matches:
            return "/matches"
        case .event(let id):
            return "/events/\(id)"
        case .eventParticipants(let id):
            return "/events/\(id)/participants"
        case .eventMatches(id: let id):
            return "/events/\(id)/matches"
        case .statsForPlayers:
            return "/stats/players"
        }
    }
}

enum IDType {
    case match
    case event
}

enum API {
    static let agent = Agent()
    static let octaneBase = URL(string: "https://zsr.octane.gg")!
    static let octaneNewsBase = URL(string: "https://content.octane.gg")!
    static let rocketeersBase = URL(string: "https://rocketeers.gg")!
    
    
    static func run<T: Decodable>(_ request: URLRequest, decodingArticleType: Agent.ArticleSource = .notAnArticle) -> AnyPublisher<T, Error> {
        let decoder: JSONDecoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
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
            URLQueryItem(name: "_limit", value: "20")
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
            URLQueryItem(name: "tier", value: "S"),
            URLQueryItem(name: "tier", value: "A"),
            URLQueryItem(name: "sort", value: "date:desc"),
            URLQueryItem(name: "perPage", value: "\(limit)")
        ]
        
        let request = URLRequest(url: components.url!)
        
        return run(request)
    }
    
    /// Get event by id
    /// - Parameter id: ID of event
    /// - Returns: `EventResult` object
    static func getEvent(byID id: String) -> AnyPublisher<EventResult, Error> {
        let components = URLComponents(string: octaneBase.appendingPathComponent(Endpoint.event(id: id).path).absoluteString)!
        
        let request = URLRequest(url: components.url!)
        
        return run(request)
    }
    
    /// Get event participants (teams + players)
    /// - Parameter eventID: Event's ID
    /// - Returns: `EventParticipants` object
    static func getParticipants(forEvent eventID: String) -> AnyPublisher<EventParticipants, Error> {
        let components = URLComponents(string: octaneBase.appendingPathComponent(Endpoint.eventParticipants(id: eventID).path).absoluteString)!
        
        let request = URLRequest(url: components.url!)
        
        return run(request)
    }
    
    /// Get top performers for event (based on Octane's player rating)
    /// - Parameter id: Event ID or match ID
    /// - Parameter idType: IDType
    /// - Returns: **Unsorted** array of TopPerformers
    static func getTopPerformers(forID id: String, idType: IDType) -> AnyPublisher<TopPerformers, Error> {
        var components = URLComponents(string: octaneBase.appendingPathComponent(Endpoint.statsForPlayers.path).absoluteString)!
        
        components.queryItems = [
            URLQueryItem(name: String(describing: idType), value: id),
            URLQueryItem(name: "stat", value: "rating")
        ]
        
        let request = URLRequest(url: components.url!)
        
        return run(request)
    }
    
    /// Get matches for event
    /// - Parameter eventID: Event ID ( the slug)
    /// - Returns: `MatchResult`
    static func getMatches(forEvent eventID: String) -> AnyPublisher<MatchResponse, Error> {
        let components = URLComponents(string: octaneBase.appendingPathComponent(Endpoint.eventMatches(id: eventID).path).absoluteString)!
        
        let request = URLRequest(url: components.url!)
        
        return run(request)
    }
    
    /// Retrieves all active teams from Octane.gg
    /// - Returns: **Unsorted** array of active teams
    static func getActiveTeams() -> AnyPublisher<ActiveTeamsResponse, Error> {
        let components = URLComponents(string: octaneBase.appendingPathComponent(Endpoint.activeTeams.path).absoluteString)!
        
        let request = URLRequest(url: components.url!)
        
        return run(request)
    }
}
