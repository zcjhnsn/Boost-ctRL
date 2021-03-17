//
//  RocketeersArticle.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/14/21.
//

import Foundation

// MARK: - Article
struct RocketeersArticle: Codable {
    let id: Int
    let link: String
    let title: Title
    let embedded: Embedded
    
    enum CodingKeys: String, CodingKey {
        case id, link, title
        case embedded = "_embedded"
    }
}

// MARK: - Embedded
struct Embedded: Codable {
    let wpFeaturedmedia: [WpFeaturedmedia]
    
    enum CodingKeys: String, CodingKey {
        case wpFeaturedmedia = "wp:featuredmedia"
    }
}

// MARK: - WpFeaturedmedia
struct WpFeaturedmedia: Codable {
    let mediaDetails: MediaDetails
    
    enum CodingKeys: String, CodingKey {
        case mediaDetails = "media_details"
    }
}

// MARK: - MediaDetails
struct MediaDetails: Codable {
    let sizes: Sizes
}

// MARK: - Sizes
struct Sizes: Codable {
    let medium, mediumLarge, large: Medium
    
    enum CodingKeys: String, CodingKey {
        case medium
        case mediumLarge = "medium_large"
        case large
    }
}

// MARK: - Medium
struct Medium: Codable {
    let sourceURL: String
    
    enum CodingKeys: String, CodingKey {
        case sourceURL = "source_url"
    }
}

// MARK: - Title
struct Title: Codable {
    let rendered: String
}

typealias RocketeersArticles = [RocketeersArticle]
