//
//  EventsResponse.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 2/5/22.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let eventsResponse = try? newJSONDecoder().decode(EventsResponse.self, from: jsonData)

import Foundation

// MARK: - EventsResponse
struct EventsResponse: Codable {
    let events: [Event]
    let page, perPage, pageSize: Int
}

// MARK: - Event
struct Event: Codable, Hashable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id && lhs.slug == rhs.slug && lhs.name == rhs.name
    }
    
    @DecodableDefault.Slug var id: String
    let slug, name: String
    let startDate, endDate: Date?
    let region: Region
    let mode: Int
    @DecodableDefault.NoPrize var prize: Prize
    let tier: Tier
    let image: String?
    @DecodableDefault.EmptyList var groups: [String]
    @DecodableDefault.NoStages var stages: [Stage]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case slug, name, startDate, endDate, region, mode, prize, tier, image, groups, stages
    }
    
    func hasLAN() -> Bool {
        return stages.contains(where: { $0.lan == true })
    }
}

/*
 struct Stage: Codable, Hashable {
     let id: Int
     let name: String

     enum CodingKeys: String, CodingKey {
         case id = "_id"
         case name
     }
 }
 */


// MARK: - Stage
struct Stage: Codable, Hashable {
    static func == (lhs: Stage, rhs: Stage) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    let id: Int
    let name: String
    let region: Region?
    let startDate, endDate: Date?
    let prize: Prize?
    let liquipedia: String?
    let lan: Bool?
    let location: Location?
    let qualifier: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, region, startDate, endDate, prize, liquipedia, lan, location, qualifier
    }
}

// MARK: - Location
struct Location: Codable, Hashable {
    let venue, city, country: String?
}

enum Tier: String, Codable, Comparable {
    case any = "Any"
    case s = "S"
    case a = "A"
    case b = "B"
    case c = "C"
    case d = "D"
    case monthly = "Monthly"
    case weekly = "Weekly"
    case qualifier = "Qualifier"
    case showMatch = "Show Match"
    
    private var sortOrder: Int {
        switch self {
        case .s:
            return 8
        case .a:
            return 7
        case .b:
            return 6
        case .c:
            return 5
        case .d:
            return 4
        case .monthly:
            return 3
        case .weekly:
            return 2
        case .qualifier:
            return 1
        case .showMatch:
            return 0
        default:
            return -1
        }
    }
    
    static func == (lhs: Tier, rhs: Tier) -> Bool {
        return lhs.sortOrder == rhs.sortOrder
    }
    
    static func < (lhs: Tier, rhs: Tier) -> Bool {
        return lhs.sortOrder < rhs.sortOrder
    }
    
    static func > (lhs: Tier, rhs: Tier) -> Bool {
        return lhs.sortOrder > rhs.sortOrder
    }
}
