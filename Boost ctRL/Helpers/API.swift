//
//  API.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 4/29/20.
//  Copyright © 2020 Zac Johnson. All rights reserved.
//

import Foundation

enum Router {
	
	// MARK: - Routes
	
	case getAppAccessToken
	case getNewsOctane
	case getNewsRocketeers
	case getLivePlayers
	
	
	
	// MARK: - Scheme
	
	var scheme: String {
		switch self {
		case .getNewsOctane, .getNewsRocketeers, .getLivePlayers, .getAppAccessToken:
			return "https"
		}
	}
	
	
	// MARK: - Host
	
	var host: String {
		switch self {
		case .getNewsOctane:
			return "api.octane.gg"
		case .getNewsRocketeers:
			return "rocketeers.gg"
		case .getLivePlayers:
			return "api.twitch.tv"
		case .getAppAccessToken:
			return "id.twitch.tv"
		}
	}
	
	
	// MARK: - Path
	
	var path: String {
		switch self {
			
		case .getNewsOctane:
			return "/api/news_section"
			
		case .getNewsRocketeers:
			return "/wp-json/wp/v2/posts"
			
		case .getLivePlayers:
			return "/helix/streams"
		
		case .getAppAccessToken:
			return "/oauth2/token"
		}
	}
	
	
	// MARK: - Parameters
	
	var parameters: [URLQueryItem]? {
		// let accessToken = ""
		switch self {
		case .getNewsRocketeers:
			return [
				URLQueryItem(name: "per_page", value: "10"),
				URLQueryItem(name: "_embed", value: "")
			]
		case .getLivePlayers:
			return [
				URLQueryItem(name: "game_id", value: Constants.TwitchIDForRL)
			]
		default:
			return nil
		}
	}

	
	// MARK: - Method
	
	var method: String {
		switch self {
		case .getNewsRocketeers, .getNewsOctane, .getLivePlayers:
			return "GET"
		case .getAppAccessToken:
			return "POST"
		}
	}
}

// MARK: - API

class API {
	
	/// Requests an array of objects from API
	/// - Parameters:
	///   - router: Route to send request
	///   - queryItems: Custom parameters (optional)
	///   - completion: Handle result
	/// - Returns: Void
	class func request<T: Codable>(router: Router, queryItems: [URLQueryItem]? = nil, completion: @escaping (Result<[T], Error>) -> ()) {
		// 2.
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = queryItems ?? router.parameters
        // 3.
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        // 4.
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            // 5.
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription)
                return
            }
            guard response != nil else {
                return
            }
            guard let data = data else {
                return
            }
            // 6.
            let responseObject = try! JSONDecoder().decode([T].self, from: data)
            // 7.
            DispatchQueue.main.async {
                // 8.
                completion(.success(responseObject))
            }
        }
        dataTask.resume()
	}
	
	
	/// Requests a single object from API
	/// - Parameters:
	///   - router: Route to send request
	///   - queryItems: Custom parameters
	///   - completion: Handle Result
	/// - Returns: Void
	class func request<T: Codable>(router: Router, queryItems: [URLQueryItem]? = nil, completion: @escaping (Result<T, Error>) -> ()) {
		// 2.
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = queryItems ?? router.parameters
        // 3.
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
		
		print("💙💙💙💙💙💙💙💙💙 - \(urlRequest)")
        // 4.
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            // 5.
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription)
                return
            }
            guard response != nil else {
                return
            }
            guard let data = data else {
                return
            }
			
            // 6.
            let responseObject = try! JSONDecoder().decode(T.self, from: data)
            // 7.
            DispatchQueue.main.async {
                // 8.
                completion(.success(responseObject))
            }
        }
        dataTask.resume()
	}
	
	/// Requests a single object from Twitch
	/// - Parameters:
	///   - router: Route to send request
	///   - queryItems: Custom parameters
	///   - completion: Handle Result
	/// - Returns: Void
	class func twitchRequest<T: Codable>(router: Router, clientID: String, token: String, completion: @escaping (Result<T, Error>) -> ()) {
		// 2.
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        // 3.
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
		urlRequest.setValue(clientID, forHTTPHeaderField: "Client-ID")
		urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		print("💜💜💜💜💜💜💜💜💜 - \(urlRequest) - \(token)")
        // 4.
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            // 5.
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription)
                return
            }
            guard response != nil else {
                return
            }
            guard let data = data else {
                return
            }
			
			if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
				print("✅")
				print(json)
			}
			
            // 6.
            let responseObject = try! JSONDecoder().decode(T.self, from: data)
            // 7.
            DispatchQueue.main.async {
                // 8.
                completion(.success(responseObject))
            }
        }
        dataTask.resume()
	}
}

