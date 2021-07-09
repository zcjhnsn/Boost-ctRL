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
    
    enum ArticleSource {
        case octaneNews
        case rocketeersNews
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
//                print(String(data: result.data, encoding: .utf8))
//                print(request.url?.absoluteString)
                let value = try decoder.decode(T.self, from: result.data) // Parse the data
                return Response(value: value, response: result.response) //
            }
            .receive(on: DispatchQueue.main) // 6
            .eraseToAnyPublisher() // 7
    }
}

extension CodingUserInfoKey {
    static let newsSite = CodingUserInfoKey(rawValue: "site")!
}
