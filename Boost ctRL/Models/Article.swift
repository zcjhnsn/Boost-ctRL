//
//  Article.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/13/21.
//

import Foundation
import SwiftUI

// MARK: - Article
struct Article: Codable, Identifiable {
    let title, articleDescription, slug: String
    let publishedAt: Date
    let image: ArticleImage
    let authors: [Author]
    let id: String
    
    var link: String {
        "https://shiftrle.gg/articles/\(slug)"
    }

    enum CodingKeys: String, CodingKey {
        case title
        case articleDescription = "description"
        case publishedAt = "published_at"
        case slug, image, authors, id
    }
}

// MARK: - Author
struct Author: Codable {
    let name, id: String
}

// MARK: - Image
struct ArticleImage: Codable {
    let url: URL
}

typealias Articles = [Article]

enum Browsers {
    case chrome
    case duckduckgo
    case firefox
    case safari
    case systemDefault
    
    var scheme: String {
        switch self {
        case .chrome:
            return "googlechrome://"
        case .duckduckgo:
            return "ddgQuickLink://"
        case .firefox:
            return "firefox://"
        case .safari:
            return "x-web-search://"
        default:
            return ""
        }
    }
}
