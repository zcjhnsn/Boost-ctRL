//
//  NewsAPI.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/14/21.
//

import Foundation
import Combine

enum Function {
    case newsRocketeers
    case newsOctane
    case pandaLeagues
    
    var path: String {
        switch self {
        case .newsOctane:
            return "/getOctaneArticles"
        case .newsRocketeers:
            return "/getRocketeersArticles"
        case .pandaLeagues:
            return "/getLeagues"
        }
    }
}

enum API {
    static let agent = Agent()
    static let base = URL(string: "https://us-central1-boost-ctrl.cloudfunctions.net")!
//    static let octaneBase = URL(string: "https://api.octane.gg")!
//    static let rocketeersBase = URL(string: "https://rocketeers.gg")!
    
    
    static func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    static func getRocketeersArticles() -> AnyPublisher<[Article], Error> {
        let components = URLComponents(string: base.appendingPathComponent(Function.newsRocketeers.path).absoluteString)!
        
        let request = URLRequest(url: components.url!)
        return run(request)
    }
    
    static func getOctaneArticles() -> AnyPublisher<[Article], Error> {
        let components = URLComponents(string: base.appendingPathComponent(Function.newsOctane.path).absoluteString)!
        
        let request = URLRequest(url: components.url!)
        return run(request)
    }
}
