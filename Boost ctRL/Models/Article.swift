//
//  Article.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/13/21.
//

import Foundation
import SwiftUI

struct Article: Identifiable, Hashable, Codable {
    let id: String
    let image: String
    let link: String
    let title: String
    let description: String?
    let date: Date
    let author: String?
    
    var newsSource: NewsSource {
        return link.lowercased().contains(NewsSource.shift.rawValue.lowercased()) ? .shift : .octane
    }
    
    var baseURL: String {
        return link.lowercased().contains(NewsSource.shift.rawValue.lowercased()) ? "https://shiftrle.gg" : "https://octane.gg"
    }
    
    struct OctaneImage: Decodable {
        let url: String
    }
    
    struct ShiftAuthor: Decodable {
        let displayName: String
    }
    
    /// Helper enum for the decoder initializer
    ///
    /// - Note: You can control the way of decoding whatever the way you want by setting extra parameter via userInfo. See [this SO post.](https://stackoverflow.com/a/61164837/10096672)
    enum Site {
        case octane
        case shift
    }
    
    /// Error state if somehow the URL is not from either `octane.gg` or `rocketeers.gg`
    enum SiteError: Error {
        case unknownSite
    }
    
    enum OctaneCodingKeys: String, CodingKey {
        case title, image, id, slug, description, authors
        case publishedAt = "published_at"
    }
    
    enum ShiftResponseCodingKeys: String, CodingKey {
        case items
    }
    
    enum ShiftCodingKeys: String, CodingKey {
        case id, title, author
        case url = "fullUrl"
        case image = "assetUrl"
        case date = "publishOn"
    }

    init(id: String, image: String, link: String, title: String, description: String? = nil, date: Date = Date(), author: String? = nil) {
        self.id = id
        self.image = image
        self.link = link
        self.title = title
        self.description = description
        self.date = date
        self.author = author
    }
    
    // https://stackoverflow.com/a/61164837/10096672
    init(from decoder: Decoder) throws {
        // See documentation for `Site` above.
        guard let key = CodingUserInfoKey(rawValue: "site"),
              let value = decoder.userInfo[key],
              let site =  value as? Site
        else {
            throw SiteError.unknownSite
        }
        
        switch site {
        case .octane:
            let container = try decoder.container(keyedBy: OctaneCodingKeys.self)
            
            let image = try container.decode(OctaneImage.self, forKey: .image)
            let slug = try container.decode(String.self, forKey: .slug)
            let author = try container.decode([OctaneAuthor].self, forKey: .authors).first
            
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.id = try container.decode(String.self, forKey: .id)
            self.image = image.url
            self.link = "https://octane.gg/news/\(slug)"
            self.title = try container.decode(String.self, forKey: .title)
            self.date = try container.decode(Date.self, forKey: .publishedAt)
            self.author = author?.name
        
        case .shift:
            let container = try decoder.container(keyedBy: ShiftCodingKeys.self)
            
            let id = try container.decode(String.self, forKey: .id)
            let title = try container.decode(String.self, forKey: .title)
            let image = try container.decode(String.self, forKey: .image)
            let url = try container.decode(String.self, forKey: .url)
            let dateMillis = try container.decode(Double.self, forKey: .date) / 1000.0
            let author = try container.decode(ShiftAuthor.self, forKey: .author)
            
            self.description = nil
            self.id = id
            self.image = image
            self.link = "https://shiftrle.gg\(url)"
            self.title = title
            self.date = Date(timeIntervalSince1970: dateMillis)
            self.author = author.displayName
        }
    }
}

// MARK: - Rocketeers Decoder Helpers
extension Article {
    
    struct OctaneAuthor: Decodable {
        let name: String
    }
    
    // MARK: Embedded
    struct Embedded: Codable {
        let wpFeaturedmedia: [WpFeaturedmedia]

        enum CodingKeys: String, CodingKey {
            case wpFeaturedmedia = "wp:featuredmedia"
        }
    }

    // MARK: WpFeaturedmedia
    struct WpFeaturedmedia: Codable {
        let mediaDetails: MediaDetails

        enum CodingKeys: String, CodingKey {
            case mediaDetails = "media_details"
        }
    }

    // MARK: MediaDetails
    struct MediaDetails: Codable {
        let sizes: Sizes
    }

    // MARK: Sizes
    struct Sizes: Codable {
        let large: Large
    }

    // MARK: Large
    struct Large: Codable {
        let sourceURL: String

        enum CodingKeys: String, CodingKey {
            case sourceURL = "source_url"
        }
    }

    // MARK: Title
    struct Title: Codable {
        let rendered: String
    }
}

enum NewsSource: String, CaseIterable, Codable {
    case octane = "Octane.gg"
    case shift = "Shiftrle.gg"
    
    static func allValues() -> [NewsSource] {
        return [.shift, .octane]
    }
}

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

struct ShiftResponse: Decodable {
    let items: [ShiftArticle]
}

struct ShiftArticle: Codable {
    let id: String
    let publishOn: Int
    let urlID, title: String
    let author: Author
    let fullURL: String
    let assetURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, publishOn
        case urlID = "urlId"
        case title, author
        case fullURL = "fullUrl"
        case assetURL = "assetUrl"
    }
}

// MARK: - Author
struct Author: Codable {
    let displayName: String
}
