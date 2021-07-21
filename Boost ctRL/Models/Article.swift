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
    
    var newsSource: NewsSource {
        return link.lowercased().contains(NewsSource.rocketeers.rawValue.lowercased()) ? .rocketeers : .octane
    }
    
    struct OctaneImage: Decodable {
        let url: String
    }
    
    /// Helper enum for the decoder initializer
    ///
    /// - Note: You can control the way of decoding whatever the way you want by setting extra parameter via userInfo. See [this SO post.](https://stackoverflow.com/a/61164837/10096672)
    enum Site {
        case octane
        case rocketeers
    }
    
    /// Error state if somehow the URL is not from either `octane.gg` or `rocketeers.gg`
    enum SiteError: Error {
        case unknownSite
    }
    
    enum OctaneCodingKeys: String, CodingKey {
        case title, image, id, slug, description
    }
    
    enum RocketeersCodingKeys: String, CodingKey {
            case id, link, title
            case embedded = "_embedded"
    }

    init(id: String, image: String, link: String, title: String, description: String? = nil) {
        self.id = id
        self.image = image
        self.link = link
        self.title = title
        self.description = description
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
            
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.id = try container.decode(String.self, forKey: .id)
            self.image = image.url
            self.link = "https://octane.gg/news/\(slug)"
            self.title = try container.decode(String.self, forKey: .title)
        
        case .rocketeers:
            let container = try decoder.container(keyedBy: RocketeersCodingKeys.self)
            let intID = try container.decode(Int.self, forKey: .id)
            let title = try container.decode(Title.self, forKey: .title)
            let embedded = try container.decode(Embedded.self, forKey: .embedded)
            
            self.description = nil
            self.id = String(intID)
            self.image = embedded.wpFeaturedmedia[0].mediaDetails.sizes.large.sourceURL
            self.link = try container.decode(String.self, forKey: .link)
            self.title = title.rendered
        }
    }
}

// MARK: - Rocketeers Decoder Helpers
extension Article {
    
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
    case rocketeers = "Rocketeers.gg"
    
    static func allValues() -> [NewsSource] {
        return [.rocketeers, .octane]
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
