//
//  DecodableDefault.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 1/27/22.
//

import Foundation

// swiftlint:disable type_name
protocol DecodableDefaultSource {
    associatedtype Value: Decodable
    static var defaultValue: Value { get }
}

enum DecodableDefault {}

extension DecodableDefault {
    @propertyWrapper
    struct Wrapper<Source: DecodableDefaultSource> {
        typealias Value = Source.Value
        var wrappedValue = Source.defaultValue
    }
}

extension DecodableDefault.Wrapper: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = try container.decode(Value.self)
    }
}

extension KeyedDecodingContainer {
    func decode<T>(_ type: DecodableDefault.Wrapper<T>.Type,
                   forKey key: Key) throws -> DecodableDefault.Wrapper<T> {
        try decodeIfPresent(type, forKey: key) ?? .init()
    }
}

extension DecodableDefault {
    typealias Source = DecodableDefaultSource
    typealias List = Decodable & ExpressibleByArrayLiteral
    typealias Map = Decodable & ExpressibleByDictionaryLiteral

    enum Sources {
        enum True: Source {
            static var defaultValue: Bool { true }
        }

        enum False: Source {
            static var defaultValue: Bool { false }
        }

        enum EmptyString: Source {
            static var defaultValue: String { "" }
        }

        enum EmptyList<T: List>: Source {
            static var defaultValue: T { [] }
        }

        enum EmptyMap<T: Map>: Source {
            static var defaultValue: T { [:] }
        }
        
        enum Zero: Source {
            static var defaultValue: Int { 0 }
        }
        
        enum ZeroDouble: Source {
            static var defaultValue: Double { 0 }
        }
        
        enum ID: Source {
            static var defaultValue: String { String(UUID().uuidString) }
        }
        
        // This is gross but doing it for the lulz
        enum Slug: Source {
            static var defaultValue: String { "abcd-1234-zyxw-9876".components(separatedBy: "-").map { String(Array($0).shuffled()) }.joined(separator: "-") }
        }
        
        // Boost Control Models
        enum EmptyTeam: Source {
            static var defaultValue: Team {
                Team(id: String(Int.random(in: 123..<12345)), slug: "", name: "TBD", image: "", region: "")
            }
        }
        
        enum EmptyTeamInfo: Source {
            static var defaultValue: TeamInfo {
                TeamInfo(team: Team(id: String(Int.random(in: 123..<12345)), slug: "", name: "TBD", image: "", region: ""), stats: nil)
            }
        }
        
        enum EmptyTeamResult: Source {
            static var defaultValue: TeamResult {
                TeamResult(score: 0, teamInfo: TeamInfo(team: Team(id: String(Int.random(in: 123..<12345)), slug: "", name: "TBD", image: "", region: ""), stats: nil), players: [], winner: false)
            }
        }
        
        enum NoPrize: Source {
            static var defaultValue: Prize { Prize(amount: 0, currency: "USD") }
        }
        
        enum NoStages: Source {
            static var defaultValue: [Stage] { [] }
        }
        
        
    }
}

extension DecodableDefault {
    typealias True = Wrapper<Sources.True>
    typealias False = Wrapper<Sources.False>
    typealias EmptyString = Wrapper<Sources.EmptyString>
    typealias EmptyList<T: List> = Wrapper<Sources.EmptyList<T>>
    typealias EmptyMap<T: Map> = Wrapper<Sources.EmptyMap<T>>
    typealias EmptyTeam = Wrapper<Sources.EmptyTeam>
    typealias NoPrize = Wrapper<Sources.NoPrize>
    typealias NoStages = Wrapper<Sources.NoStages>
    typealias Slug = Wrapper<Sources.Slug>
    typealias Zero = Wrapper<Sources.Zero>
    typealias ZeroDouble = Wrapper<Sources.ZeroDouble>
    typealias EmptyTeamResult = Wrapper<Sources.EmptyTeamResult>
    typealias ID = Wrapper<Sources.ID>
}
// swiftlint:enable type_name


extension DecodableDefault.Wrapper: Equatable where Value: Equatable {}
extension DecodableDefault.Wrapper: Hashable where Value: Hashable {}

extension DecodableDefault.Wrapper: Encodable where Value: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}
