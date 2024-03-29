//
//  Agent.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/14/21.
//

import Combine
import Foundation

struct Agent {
    
    /// Contains both a parsed value (T) and a URLResponse instance (for status code validation/logging
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    enum ShiftResponseCodingKeys: String, CodingKey {
        case items
    }
    
    enum ArticleSource {
        case octaneNews
        case shiftNews
        case notAnArticle
    }
    
    /// Single entry point for request execution
    /// - Parameters:
    ///   - request: URLRequest instance that fully describes the request configuration
    ///   - decoder: Optional JSONDecoder
    ///   - source: Optional Source specification
    /// - Returns: Response<T>
    func run<T: Decodable>(_ request: URLRequest,
                           _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request) // Create data task as Combine publisher
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data) // Parse the data
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension CodingUserInfoKey {
    static let newsSite = CodingUserInfoKey(rawValue: "site")!
}
