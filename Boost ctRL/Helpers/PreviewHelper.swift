//
//  PreviewHelper.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/6/21.
//

import Foundation

struct PreviewHelper {
    
    static let DATE: String = "2021-06-20T19:00:00Z"
    
    static let TEAM_RESULT_NA_1: TeamResult = TeamResult(
        score: 3,
        teamInfo: MOCK_TEAM_INFO_NA_1,
        players: [
            PLAYER_RESULT,
            PLAYER_RESULT,
            PLAYER_RESULT
        ],
        winner: true
    )
    
    static let MOCK_GAME1: Game = Game(id: UUID().uuidString, blue: 1, orange: 0, duration: 340, overtime: true, ballchasing: "")
    static let MOCK_GAME2: Game = Game(id: UUID().uuidString, blue: 2, orange: 4, duration: 300, overtime: false, ballchasing: "")
    static let MOCK_GAME3: Game = Game(id: UUID().uuidString, blue: 0, orange: 1, duration: 300, overtime: true, ballchasing: "")
    static let MOCK_GAME4: Game = Game(id: UUID().uuidString, blue: 3, orange: 1, duration: 300, overtime: false, ballchasing: "")
    static let MOCK_GAME5: Game = Game(id: UUID().uuidString, blue: 4, orange: 3, duration: 400, overtime: true, ballchasing: "")
    static let MOCK_GAME6: Game = Game(id: UUID().uuidString, blue: 0, orange: 1, duration: 303, overtime: true, ballchasing: "")
    static let MOCK_GAME7: Game = Game(id: UUID().uuidString, blue: 2, orange: 0, duration: 300, overtime: false, ballchasing: "")
    
    static let PLAYER_RESULT: PlayerResult = PlayerResult(
        player: PLAYER,
        stats: nil,
        advanced: nil
    )
    
    static let PLAYER: Player = Player(
        id: "gg",
        slug: "garrettg",
        tag: "GarrettG",
        country: "us"
    )
    
    static let MOCK_PARTICIPANTS: [Participant] = [
        Participant(team: MOCK_TEAM_NA_1, players: [PLAYER, PLAYER, PLAYER]),
        Participant(team: MOCK_TEAM_NA_1, players: [PLAYER, PLAYER, PLAYER]),
        Participant(team: MOCK_TEAM_NA_1, players: [PLAYER, PLAYER, PLAYER]),
        Participant(team: MOCK_TEAM_NA_1, players: [PLAYER, PLAYER, PLAYER]),
        Participant(team: MOCK_TEAM_NA_1, players: [PLAYER, PLAYER, PLAYER]),
        Participant(team: MOCK_TEAM_NA_1, players: [PLAYER, PLAYER, PLAYER])
    ]
    
    static let MOCK_TOP_PERFORMERS: [TopPerformer] = [
        TopPerformer(player: PLAYER, teams: [MOCK_TEAM_NA_1], games: Games(total: 0, replays: 0, wins: 0, seconds: 0, replaySeconds: 0), stats: Stats(rating: 1.000)),
        TopPerformer(player: PLAYER, teams: [MOCK_TEAM_NA_1], games: Games(total: 0, replays: 0, wins: 0, seconds: 0, replaySeconds: 0), stats: Stats(rating: 1.000)),
        TopPerformer(player: PLAYER, teams: [MOCK_TEAM_NA_1], games: Games(total: 0, replays: 0, wins: 0, seconds: 0, replaySeconds: 0), stats: Stats(rating: 1.000)),
        TopPerformer(player: PLAYER, teams: [MOCK_TEAM_NA_1], games: Games(total: 0, replays: 0, wins: 0, seconds: 0, replaySeconds: 0), stats: Stats(rating: 1.000)),
        TopPerformer(player: PLAYER, teams: [MOCK_TEAM_NA_1], games: Games(total: 0, replays: 0, wins: 0, seconds: 0, replaySeconds: 0), stats: Stats(rating: 1.000)),
    ]
    
    static let MOCK_TEAM_INFO_NA_1: TeamInfo = TeamInfo(team: MOCK_TEAM_NA_1, stats: nil)
    
    static let MOCK_TEAM_NA_1: Team = Team(
        id: "1",
        slug: "nrg",
        name: "NRG Esports",
        image: "https://griffon.octane.gg/teams/nrg-esports.png"
    )
    
    static let MOCK_PLAYER_ACTIVE: ActivePlayer = ActivePlayer(id: "1", slug: "gg", tag: "GarrettG", name: "Garrett Gordon", country: "us", team: MOCK_ACTIVE_TEAM_INFO, relevant: true, coach: false)
    
    static let MOCK_ACTIVE_TEAM_INFO = ActiveTeamInfo(id: "1", slug: "nrg", name: "NRG Esports", region: Region.na, image: "https://griffon.octane.gg/teams/nrg-esports.png", relevant: true)
    
    static let MOCK_ACTIVE_TEAM: ActiveTeam = ActiveTeam(team: MOCK_ACTIVE_TEAM_INFO, players: [
        MOCK_PLAYER_ACTIVE,
        MOCK_PLAYER_ACTIVE,
        MOCK_PLAYER_ACTIVE
    ])
    
    static let MOCK_ACTIVE_TEAM_RESPONSE: ActiveTeamsResponse = ActiveTeamsResponse(teams: [MOCK_ACTIVE_TEAM, MOCK_ACTIVE_TEAM, MOCK_ACTIVE_TEAM])
    
    static let FORMAT = Format(type: "best", length: 3)
    
    static let EVENT = Event(id: "123", slug: "123", name: "RLCS XI Fall Major", region: "na", mode: 3, tier: "S", image: "https://griffon.octane.gg/events/rlcs-x-championships.png", groups: ["rlcsxi"])
    
    static let STAGE = Stage(id: 123, name: "asdf")
    
    static let MATCH_GENERIC = Match(
        id: "123123123",
        slug: "123123",
        event: EVENT,
        stage: STAGE,
        date: DATE,
        format: FORMAT,
        blue: TeamResult(
            score: 3,
            teamInfo: MOCK_TEAM_INFO_NA_1,
            players: [
                PLAYER_RESULT,
                PLAYER_RESULT,
                PLAYER_RESULT
            ],
            winner: true
        ),
        orange: TeamResult(
            score: 2,
            teamInfo: TeamInfo(team: Team(
                id: "1",
                slug: "ssg",
                name: "Spacestation Gaming",
                image: "https://griffon.octane.gg/teams/Spacestation_Gaming_2021.png"
            ),
            stats: nil
            ),
            players: [
                PLAYER_RESULT,
                PLAYER_RESULT,
                PLAYER_RESULT
            ],
            winner: false
        ),
        number: 1,
        games: [
            MOCK_GAME1,
            MOCK_GAME2,
            MOCK_GAME3,
            MOCK_GAME4,
            MOCK_GAME5
        ])
    
    static let EVENT_RESULT = createEvent()!
    
    static let MATCH = createMatch(from: MATCH_JSON)
    
    static func createEvent() -> EventResult? {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let event = try EventResult(json: EVENT_JSON, using: decoder)
            return event
        } catch let error {
            print("❌ Failed - Could not create preview event - \(error)")
        }
        
        return nil
    }
    
    static func createMatch(from json: String) -> Match {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let match = try Match(json: MATCH_JSON, using: decoder)
            print("❌ Failed - Could not create preview match")
            return match
        } catch {
            print(error)
        }
        return MATCH_GENERIC
    }
    
    static let EVENT_JSON = """
        {
          "_id": "609798263dfdaa8e09bfe851",
          "slug": "e851-rlcs-x-championship-north-america",
          "name": "RLCS X Championship North America (Example)",
          "startDate": "2021-06-15T17:00:00Z",
          "endDate": "2021-06-20T21:00:00Z",
          "region": "NA",
          "mode": 3,
          "prize": {
            "amount": 400000,
            "currency": "USD"
          },
          "tier": "S",
          "image": "https://griffon.octane.gg/events/rlcs-x-championships.png",
          "groups": [
            "rlcs",
            "rlcsx",
            "rlcsxchampionships"
          ],
          "stages": [
            {
              "_id": 0,
              "name": "Main Event",
              "startDate": "2021-06-15T08:06:50Z",
              "endDate": "2021-06-20T22:30:00Z",
              "prize": {
                "amount": 400000,
                "currency": "USD"
              },
              "liquipedia": "https://liquipedia.net/rocketleague/Rocket_League_Championship_Series/Season_X/Championships/North_America"
            }
          ]
        }
        """
    
    static let MATCH_JSON = """
        [
          {
            "_id": "609798e63dfdaa8e09bfe862",
            "slug": "e862-spacestation-gaming-vs-nrg-esports",
            "event": {
              "_id": "609798263dfdaa8e09bfe851",
              "slug": "e851-rlcs-x-championship-north-america",
              "name": "RLCS X Championship North America",
              "region": "NA",
              "mode": 3,
              "tier": "S",
              "image": "https://griffon.octane.gg/events/rlcs-x-championships.png",
              "groups": [
                "rlcs",
                "rlcsx",
                "rlcsxchampionships"
              ]
            },
            "stage": {
              "_id": 0,
              "name": "Main Event"
            },
            "date": "2021-06-20T19:00:00Z",
            "format": {
              "type": "best",
              "length": 7
            },
            "blue": {
              "score": 1,
              "team": {
                "team": {
                  "_id": "6020bc70f1e4807cc7002389",
                  "slug": "2389-spacestation-gaming",
                  "name": "Spacestation Gaming",
                  "image": "https://griffon.octane.gg/teams/Spacestation_Gaming_2021.png"
                },
                "stats": {
                  "core": {
                    "shots": 40,
                    "goals": 3,
                    "saves": 34,
                    "assists": 2,
                    "score": 5395,
                    "shootingPercentage": 7.5
                  },
                  "boost": {
                    "bpm": 6502,
                    "bcpm": 6573.14744,
                    "avgAmount": 701.66,
                    "amountCollected": 41578,
                    "amountStolen": 8144,
                    "amountCollectedBig": 28764,
                    "amountStolenBig": 4381,
                    "amountCollectedSmall": 12814,
                    "amountStolenSmall": 3763,
                    "countCollectedBig": 339,
                    "countStolenBig": 47,
                    "countCollectedSmall": 1097,
                    "countStolenSmall": 328,
                    "amountOverfill": 5182,
                    "amountOverfillStolen": 334,
                    "amountUsedWhileSupersonic": 8179,
                    "timeZeroBoost": 842.1899999999999,
                    "timeFullBoost": 518.13,
                    "timeBoost0To25": 2273,
                    "timeBoost25To50": 1134.43,
                    "timeBoost50To75": 960.28,
                    "timeBoost75To100": 1333.36
                  },
                  "movement": {
                    "totalDistance": 8762620,
                    "timeSupersonicSpeed": 985,
                    "timeBoostSpeed": 2370.1800000000003,
                    "timeSlowSpeed": 2450.88,
                    "timeGround": 3328.5299999999997,
                    "timeLowAir": 2177.89,
                    "timeHighAir": 299.65999999999997,
                    "timePowerslide": 140.60999999999999,
                    "countPowerslide": 1282
                  },
                  "positioning": {
                    "timeDefensiveThird": 2821.4,
                    "timeNeutralThird": 1789.34,
                    "timeOffensiveThird": 1195.3200000000002,
                    "timeDefensiveHalf": 3771.8399999999997,
                    "timeOffensiveHalf": 2034.15,
                    "timeBehindBall": 4018.84,
                    "timeInfrontBall": 1787.21
                  },
                  "demo": {
                    "inflicted": 25,
                    "taken": 20
                  }
                }
              },
              "players": [
                {
                  "player": {
                    "_id": "5f3d8fdd95f40596eae23ede",
                    "slug": "3ede-sypical",
                    "tag": "Sypical",
                    "country": "us"
                  },
                  "stats": {
                    "core": {
                      "shots": 14,
                      "goals": 1,
                      "saves": 11,
                      "assists": 0,
                      "score": 1800,
                      "shootingPercentage": 7.142857142857142
                    },
                    "boost": {
                      "bpm": 2148,
                      "bcpm": 2111.27139,
                      "avgAmount": 248.87000000000003,
                      "amountCollected": 13390,
                      "amountStolen": 2344,
                      "amountCollectedBig": 9249,
                      "amountStolenBig": 1424,
                      "amountCollectedSmall": 4141,
                      "amountStolenSmall": 920,
                      "countCollectedBig": 112,
                      "countStolenBig": 15,
                      "countCollectedSmall": 352,
                      "countStolenSmall": 82,
                      "amountOverfill": 1952,
                      "amountOverfillStolen": 72,
                      "amountUsedWhileSupersonic": 2394,
                      "timeZeroBoost": 271.78,
                      "percentZeroBoost": 13.921975,
                      "timeFullBoost": 163.66,
                      "percentFullBoost": 8.82323574,
                      "timeBoost0To25": 651.46,
                      "timeBoost25To50": 362.3,
                      "timeBoost50To75": 343.95,
                      "timeBoost75To100": 505.55,
                      "percentBoost0To25": 34.1514078,
                      "percentBoost25To50": 19.4501382,
                      "percentBoost50To75": 19.0304594,
                      "percentBoost75To100": 27.367999000000005
                    },
                    "movement": {
                      "avgSpeed": 7794,
                      "totalDistance": 2887189,
                      "timeSupersonicSpeed": 328.91,
                      "timeBoostSpeed": 764.6300000000001,
                      "timeSlowSpeed": 827.8299999999999,
                      "timeGround": 1054.02,
                      "timeLowAir": 749.3199999999999,
                      "timeHighAir": 118.03,
                      "timePowerslide": 42.339999999999996,
                      "countPowerslide": 437,
                      "avgPowerslideDuration": 0.48,
                      "avgSpeedPercentage": 67.773912,
                      "percentSlowSpeed": 42.561991,
                      "percentBoostSpeed": 40.4127704,
                      "percentSupersonicSpeed": 17.025236800000002,
                      "percentGround": 55.141978200000004,
                      "percentLowAir": 38.7018004,
                      "percentHighAir": 6.15622054
                    },
                    "positioning": {
                      "avgDistanceToBall": 15014,
                      "avgDistanceToBallPossession": 14186,
                      "avgDistanceToBallNoPossession": 15839,
                      "avgDistanceToMates": 19428,
                      "timeDefensiveThird": 1017.98,
                      "timeNeutralThird": 549.27,
                      "timeOffensiveThird": 354.11,
                      "timeDefensiveHalf": 1312.53,
                      "timeOffensiveHalf": 608.8199999999999,
                      "timeBehindBall": 1380.3200000000002,
                      "timeInfrontBall": 541.04,
                      "timeMostBack": 762.3999999999999,
                      "timeMostForward": 570,
                      "goalsAgainstWhileLastDefender": 3,
                      "timeClosestToBall": 615,
                      "timeFarthestFromBall": 717.4,
                      "percentDefensiveThird": 53.3200418,
                      "percentOffensiveThird": 18.5583886,
                      "percentNeutralThird": 28.121567600000002,
                      "percentDefensiveHalf": 68.4246548,
                      "percentOffensiveHalf": 31.575345999999996,
                      "percentBehindBall": 72.63144980000001,
                      "percentInfrontBall": 27.368549800000004,
                      "percentMostBack": 41.058822,
                      "percentMostForward": 28.889818399999996,
                      "percentClosestToBall": 32.3998858,
                      "percentFarthestFromBall": 37.797774600000004
                    },
                    "demo": {
                      "inflicted": 7,
                      "taken": 11
                    }
                  },
                  "advanced": {
                    "goalParticipation": 33.33333333333333,
                    "rating": 0.5979953533180551
                  }
                },
                {
                  "player": {
                    "_id": "5f3d8fdd95f40596eae23eda",
                    "slug": "3eda-arsenal",
                    "tag": "Arsenal",
                    "country": "us"
                  },
                  "stats": {
                    "core": {
                      "shots": 12,
                      "goals": 0,
                      "saves": 7,
                      "assists": 2,
                      "score": 1361,
                      "shootingPercentage": 0
                    },
                    "boost": {
                      "bpm": 2096,
                      "bcpm": 2169.37893,
                      "avgAmount": 227.89,
                      "amountCollected": 13672,
                      "amountStolen": 2401,
                      "amountCollectedBig": 9359,
                      "amountStolenBig": 1228,
                      "amountCollectedSmall": 4313,
                      "amountStolenSmall": 1173,
                      "countCollectedBig": 105,
                      "countStolenBig": 13,
                      "countCollectedSmall": 371,
                      "countStolenSmall": 103,
                      "amountOverfill": 1214,
                      "amountOverfillStolen": 79,
                      "amountUsedWhileSupersonic": 2613,
                      "timeZeroBoost": 305.29,
                      "percentZeroBoost": 15.881946800000003,
                      "timeFullBoost": 179.60000000000002,
                      "percentFullBoost": 9.4755094,
                      "timeBoost0To25": 850.11,
                      "timeBoost25To50": 388.41,
                      "timeBoost50To75": 281.01,
                      "timeBoost75To100": 413.28999999999996,
                      "percentBoost0To25": 43.6973642,
                      "percentBoost25To50": 20.0699788,
                      "percentBoost50To75": 14.336702400000002,
                      "percentBoost75To100": 21.895954600000003
                    },
                    "movement": {
                      "avgSpeed": 7802,
                      "totalDistance": 2913579,
                      "timeSupersonicSpeed": 318.39,
                      "timeBoostSpeed": 778.04,
                      "timeSlowSpeed": 851.26,
                      "timeGround": 1089.54,
                      "timeLowAir": 754.48,
                      "timeHighAir": 103.67,
                      "timePowerslide": 58.43,
                      "countPowerslide": 494,
                      "avgPowerslideDuration": 0.6,
                      "avgSpeedPercentage": 67.8434788,
                      "percentSlowSpeed": 42.701329799999996,
                      "percentBoostSpeed": 40.359502199999994,
                      "percentSupersonicSpeed": 16.9391642,
                      "percentGround": 55.78125439999999,
                      "percentLowAir": 38.880290599999995,
                      "percentHighAir": 5.33845628
                    },
                    "positioning": {
                      "avgDistanceToBall": 13789,
                      "avgDistanceToBallPossession": 12984,
                      "avgDistanceToBallNoPossession": 14613,
                      "avgDistanceToMates": 18898,
                      "timeDefensiveThird": 918.4100000000001,
                      "timeNeutralThird": 616.53,
                      "timeOffensiveThird": 412.74,
                      "timeDefensiveHalf": 1252.21,
                      "timeOffensiveHalf": 695.41,
                      "timeBehindBall": 1326.46,
                      "timeInfrontBall": 621.23,
                      "timeMostBack": 600.9,
                      "timeMostForward": 639.2,
                      "goalsAgainstWhileLastDefender": 2,
                      "timeClosestToBall": 639.8,
                      "timeFarthestFromBall": 586.3,
                      "percentDefensiveThird": 45.8165796,
                      "percentOffensiveThird": 21.709762,
                      "percentNeutralThird": 32.4736552,
                      "percentDefensiveHalf": 63.327148199999996,
                      "percentOffensiveHalf": 36.6728494,
                      "percentBehindBall": 67.74834580000001,
                      "percentInfrontBall": 32.251653399999995,
                      "percentMostBack": 30.556365399999997,
                      "percentMostForward": 33.9717356,
                      "percentClosestToBall": 33.341009199999995,
                      "percentFarthestFromBall": 30.490464600000003
                    },
                    "demo": {
                      "inflicted": 9,
                      "taken": 3
                    }
                  },
                  "advanced": {
                    "goalParticipation": 66.66666666666666,
                    "rating": 0.537453286072844
                  }
                },
                {
                  "player": {
                    "_id": "5f663e7728947d10dd334263",
                    "slug": "4263-retals",
                    "tag": "retals",
                    "country": "us"
                  },
                  "stats": {
                    "core": {
                      "shots": 14,
                      "goals": 2,
                      "saves": 16,
                      "assists": 0,
                      "score": 2234,
                      "shootingPercentage": 14.285714285714285
                    },
                    "boost": {
                      "bpm": 2258,
                      "bcpm": 2292.49712,
                      "avgAmount": 224.89999999999998,
                      "amountCollected": 14516,
                      "amountStolen": 3399,
                      "amountCollectedBig": 10156,
                      "amountStolenBig": 1729,
                      "amountCollectedSmall": 4360,
                      "amountStolenSmall": 1670,
                      "countCollectedBig": 122,
                      "countStolenBig": 19,
                      "countCollectedSmall": 374,
                      "countStolenSmall": 143,
                      "amountOverfill": 2016,
                      "amountOverfillStolen": 183,
                      "amountUsedWhileSupersonic": 3172,
                      "timeZeroBoost": 265.12,
                      "percentZeroBoost": 14.539617400000001,
                      "timeFullBoost": 174.86999999999998,
                      "percentFullBoost": 9.130296,
                      "timeBoost0To25": 771.43,
                      "timeBoost25To50": 383.71999999999997,
                      "timeBoost50To75": 335.32,
                      "timeBoost75To100": 414.52,
                      "percentBoost0To25": 40.542352199999996,
                      "percentBoost25To50": 20.533933400000002,
                      "percentBoost50To75": 17.423331400000002,
                      "percentBoost75To100": 21.500381
                    },
                    "movement": {
                      "avgSpeed": 7948,
                      "totalDistance": 2961852,
                      "timeSupersonicSpeed": 337.70000000000005,
                      "timeBoostSpeed": 827.51,
                      "timeSlowSpeed": 771.79,
                      "timeGround": 1184.97,
                      "timeLowAir": 674.0899999999999,
                      "timeHighAir": 77.96000000000001,
                      "timePowerslide": 39.839999999999996,
                      "countPowerslide": 351,
                      "avgPowerslideDuration": 0.57,
                      "avgSpeedPercentage": 69.1130448,
                      "percentSlowSpeed": 39.53420179999999,
                      "percentBoostSpeed": 42.940305800000004,
                      "percentSupersonicSpeed": 17.525494,
                      "percentGround": 61.325400200000004,
                      "percentLowAir": 34.641521399999995,
                      "percentHighAir": 4.0330792
                    },
                    "positioning": {
                      "avgDistanceToBall": 14324,
                      "avgDistanceToBallPossession": 13591,
                      "avgDistanceToBallNoPossession": 14955,
                      "avgDistanceToMates": 19122,
                      "timeDefensiveThird": 885.01,
                      "timeNeutralThird": 623.54,
                      "timeOffensiveThird": 428.47,
                      "timeDefensiveHalf": 1207.1,
                      "timeOffensiveHalf": 729.92,
                      "timeBehindBall": 1312.06,
                      "timeInfrontBall": 624.94,
                      "timeMostBack": 577.8000000000001,
                      "timeMostForward": 686.4,
                      "goalsAgainstWhileLastDefender": 4,
                      "timeClosestToBall": 641.4,
                      "timeFarthestFromBall": 632.3,
                      "percentDefensiveThird": 44.6221088,
                      "percentOffensiveThird": 22.5728142,
                      "percentNeutralThird": 32.8050752,
                      "percentDefensiveHalf": 61.5396158,
                      "percentOffensiveHalf": 38.460384000000005,
                      "percentBehindBall": 67.43913599999999,
                      "percentInfrontBall": 32.560862,
                      "percentMostBack": 30.270418600000006,
                      "percentMostForward": 36.612455999999995,
                      "percentClosestToBall": 33.7126166,
                      "percentFarthestFromBall": 33.4207158
                    },
                    "demo": {
                      "inflicted": 9,
                      "taken": 6
                    }
                  },
                  "advanced": {
                    "goalParticipation": 66.66666666666666,
                    "rating": 0.8191087663090288
                  }
                }
              ]
            },
            "orange": {
              "score": 4,
              "winner": true,
              "team": {
                "team": {
                  "_id": "6020bc70f1e4807cc70023a0",
                  "slug": "23a0-nrg-esports",
                  "name": "NRG Esports",
                  "image": "https://griffon.octane.gg/teams/nrg-esports.png"
                },
                "stats": {
                  "core": {
                    "shots": 52,
                    "goals": 9,
                    "saves": 30,
                    "assists": 8,
                    "score": 6122,
                    "shootingPercentage": 17.307692307692307
                  },
                  "boost": {
                    "bpm": 6422,
                    "bcpm": 6516.8094200000005,
                    "avgAmount": 732.9,
                    "amountCollected": 41356,
                    "amountStolen": 8824,
                    "amountCollectedBig": 28719,
                    "amountStolenBig": 5484,
                    "amountCollectedSmall": 12637,
                    "amountStolenSmall": 3340,
                    "countCollectedBig": 354,
                    "countStolenBig": 64,
                    "countCollectedSmall": 1068,
                    "countStolenSmall": 293,
                    "amountOverfill": 6542,
                    "amountOverfillStolen": 872,
                    "amountUsedWhileSupersonic": 8278,
                    "timeZeroBoost": 650.75,
                    "timeFullBoost": 570.65,
                    "timeBoost0To25": 1940.7500000000002,
                    "timeBoost25To50": 1212.96,
                    "timeBoost50To75": 1120.87,
                    "timeBoost75To100": 1408.83
                  },
                  "movement": {
                    "totalDistance": 8778668,
                    "timeSupersonicSpeed": 1047.99,
                    "timeBoostSpeed": 2274.95,
                    "timeSlowSpeed": 2466.46,
                    "timeGround": 3448.9399999999996,
                    "timeLowAir": 2042.8899999999999,
                    "timeHighAir": 297.58000000000004,
                    "timePowerslide": 128.5,
                    "countPowerslide": 1304
                  },
                  "positioning": {
                    "timeDefensiveThird": 2853.76,
                    "timeNeutralThird": 1748.35,
                    "timeOffensiveThird": 1187.31,
                    "timeDefensiveHalf": 3795.83,
                    "timeOffensiveHalf": 1993.6200000000001,
                    "timeBehindBall": 4463.15,
                    "timeInfrontBall": 1326.27
                  },
                  "demo": {
                    "inflicted": 20,
                    "taken": 25
                  }
                }
              },
              "players": [
                {
                  "player": {
                    "_id": "5f3d8fdd95f40596eae23d6f",
                    "slug": "3d6f-garrettg",
                    "tag": "GarrettG",
                    "country": "us"
                  },
                  "stats": {
                    "core": {
                      "shots": 18,
                      "goals": 5,
                      "saves": 9,
                      "assists": 2,
                      "score": 2185,
                      "shootingPercentage": 27.77777777777778
                    },
                    "boost": {
                      "bpm": 2125,
                      "bcpm": 2183.82398,
                      "avgAmount": 241.07,
                      "amountCollected": 13869,
                      "amountStolen": 3341,
                      "amountCollectedBig": 9599,
                      "amountStolenBig": 2035,
                      "amountCollectedSmall": 4270,
                      "amountStolenSmall": 1306,
                      "countCollectedBig": 120,
                      "countStolenBig": 23,
                      "countCollectedSmall": 369,
                      "countStolenSmall": 119,
                      "amountOverfill": 2192,
                      "amountOverfillStolen": 288,
                      "amountUsedWhileSupersonic": 3660,
                      "timeZeroBoost": 199.58999999999997,
                      "percentZeroBoost": 10.7194724,
                      "timeFullBoost": 156.82999999999998,
                      "percentFullBoost": 7.9785968800000004,
                      "timeBoost0To25": 645.37,
                      "timeBoost25To50": 410.7,
                      "timeBoost50To75": 395.72,
                      "timeBoost75To100": 435.99,
                      "percentBoost0To25": 33.6966366,
                      "percentBoost25To50": 21.935980800000003,
                      "percentBoost50To75": 21.3097766,
                      "percentBoost75To100": 23.057607800000003
                    },
                    "movement": {
                      "avgSpeed": 8029,
                      "totalDistance": 2985680,
                      "timeSupersonicSpeed": 390.58,
                      "timeBoostSpeed": 750.3699999999999,
                      "timeSlowSpeed": 783.9300000000001,
                      "timeGround": 1175.02,
                      "timeLowAir": 673.04,
                      "timeHighAir": 76.84,
                      "timePowerslide": 37.55,
                      "countPowerslide": 315,
                      "avgPowerslideDuration": 0.5900000000000001,
                      "avgSpeedPercentage": 69.8173916,
                      "percentSlowSpeed": 40.7830726,
                      "percentBoostSpeed": 39.090137799999994,
                      "percentSupersonicSpeed": 20.126789199999997,
                      "percentGround": 61.0641982,
                      "percentLowAir": 34.8757948,
                      "percentHighAir": 4.0600087
                    },
                    "positioning": {
                      "avgDistanceToBall": 13688,
                      "avgDistanceToBallPossession": 13340,
                      "avgDistanceToBallNoPossession": 13872,
                      "avgDistanceToMates": 18839,
                      "timeDefensiveThird": 893.45,
                      "timeNeutralThird": 554.76,
                      "timeOffensiveThird": 476.68,
                      "timeDefensiveHalf": 1182.75,
                      "timeOffensiveHalf": 742.15,
                      "timeBehindBall": 1427.28,
                      "timeInfrontBall": 497.61,
                      "timeMostBack": 538.7,
                      "timeMostForward": 737.9,
                      "goalsAgainstWhileLastDefender": 0,
                      "timeClosestToBall": 710.9000000000001,
                      "timeFarthestFromBall": 559.3,
                      "percentDefensiveThird": 46.9254592,
                      "percentOffensiveThird": 24.289811399999998,
                      "percentNeutralThird": 28.784731,
                      "percentDefensiveHalf": 62.0440392,
                      "percentOffensiveHalf": 37.9559614,
                      "percentBehindBall": 74.15690579999999,
                      "percentInfrontBall": 25.843091199999996,
                      "percentMostBack": 28.2817346,
                      "percentMostForward": 39.162882,
                      "percentClosestToBall": 37.7163864,
                      "percentFarthestFromBall": 29.234403800000003
                    },
                    "demo": {
                      "inflicted": 13,
                      "taken": 10
                    }
                  },
                  "advanced": {
                    "goalParticipation": 77.77777777777779,
                    "rating": 1.1288892215471993
                  }
                },
                {
                  "player": {
                    "_id": "5f3d8fdd95f40596eae23dcf",
                    "slug": "3dcf-jstn",
                    "tag": "jstn.",
                    "country": "us"
                  },
                  "stats": {
                    "core": {
                      "shots": 19,
                      "goals": 3,
                      "saves": 13,
                      "assists": 3,
                      "score": 2337,
                      "shootingPercentage": 15.789473684210526
                    },
                    "boost": {
                      "bpm": 2154,
                      "bcpm": 2196.3187900000003,
                      "avgAmount": 245.81000000000003,
                      "amountCollected": 13916,
                      "amountStolen": 1979,
                      "amountCollectedBig": 9711,
                      "amountStolenBig": 1150,
                      "amountCollectedSmall": 4205,
                      "amountStolenSmall": 829,
                      "countCollectedBig": 118,
                      "countStolenBig": 14,
                      "countCollectedSmall": 351,
                      "countStolenSmall": 74,
                      "amountOverfill": 2057,
                      "amountOverfillStolen": 175,
                      "amountUsedWhileSupersonic": 2541,
                      "timeZeroBoost": 209.65,
                      "percentZeroBoost": 10.9582804,
                      "timeFullBoost": 216.51,
                      "percentFullBoost": 11.6788232,
                      "timeBoost0To25": 668.97,
                      "timeBoost25To50": 399.18,
                      "timeBoost50To75": 348.35999999999996,
                      "timeBoost75To100": 472.76,
                      "percentBoost0To25": 35.185355,
                      "percentBoost25To50": 20.854284599999996,
                      "percentBoost50To75": 18.541505100000002,
                      "percentBoost75To100": 25.418855599999997
                    },
                    "movement": {
                      "avgSpeed": 7726,
                      "totalDistance": 2855303,
                      "timeSupersonicSpeed": 325.46,
                      "timeBoostSpeed": 724.19,
                      "timeSlowSpeed": 878.52,
                      "timeGround": 1179.37,
                      "timeLowAir": 644.53,
                      "timeHighAir": 104.28,
                      "timePowerslide": 56.39,
                      "countPowerslide": 584,
                      "avgPowerslideDuration": 0.48,
                      "avgSpeedPercentage": 67.1826096,
                      "percentSlowSpeed": 44.7566744,
                      "percentBoostSpeed": 37.9734598,
                      "percentSupersonicSpeed": 17.2698655,
                      "percentGround": 61.15787300000001,
                      "percentLowAir": 33.382751400000004,
                      "percentHighAir": 5.4593763
                    },
                    "positioning": {
                      "avgDistanceToBall": 15771,
                      "avgDistanceToBallPossession": 15788,
                      "avgDistanceToBallNoPossession": 15685,
                      "avgDistanceToMates": 18820,
                      "timeDefensiveThird": 1053.41,
                      "timeNeutralThird": 569.9499999999999,
                      "timeOffensiveThird": 304.8,
                      "timeDefensiveHalf": 1365.96,
                      "timeOffensiveHalf": 562.23,
                      "timeBehindBall": 1566.31,
                      "timeInfrontBall": 361.86999999999995,
                      "timeMostBack": 821.8,
                      "timeMostForward": 468.79999999999995,
                      "goalsAgainstWhileLastDefender": 1,
                      "timeClosestToBall": 561.9,
                      "timeFarthestFromBall": 733.2,
                      "percentDefensiveThird": 54.951347999999996,
                      "percentOffensiveThird": 15.6355414,
                      "percentNeutralThird": 29.413111400000002,
                      "percentDefensiveHalf": 71.0641112,
                      "percentOffensiveHalf": 28.935894400000002,
                      "percentBehindBall": 80.49901,
                      "percentInfrontBall": 19.5009924,
                      "percentMostBack": 42.626808600000004,
                      "percentMostForward": 25.1735818,
                      "percentClosestToBall": 29.1856132,
                      "percentFarthestFromBall": 38.581116800000004
                    },
                    "demo": {
                      "inflicted": 5,
                      "taken": 9
                    }
                  },
                  "advanced": {
                    "goalParticipation": 66.66666666666666,
                    "rating": 1.1783867774579846
                  }
                },
                {
                  "player": {
                    "_id": "5f3d8fdd95f40596eae23d95",
                    "slug": "3d95-squishy",
                    "tag": "Squishy",
                    "country": "ca"
                  },
                  "stats": {
                    "core": {
                      "shots": 15,
                      "goals": 1,
                      "saves": 8,
                      "assists": 3,
                      "score": 1600,
                      "shootingPercentage": 6.666666666666667
                    },
                    "boost": {
                      "bpm": 2143,
                      "bcpm": 2136.66665,
                      "avgAmount": 246.01999999999998,
                      "amountCollected": 13571,
                      "amountStolen": 3504,
                      "amountCollectedBig": 9409,
                      "amountStolenBig": 2299,
                      "amountCollectedSmall": 4162,
                      "amountStolenSmall": 1205,
                      "countCollectedBig": 116,
                      "countStolenBig": 27,
                      "countCollectedSmall": 348,
                      "countStolenSmall": 100,
                      "amountOverfill": 2293,
                      "amountOverfillStolen": 409,
                      "amountUsedWhileSupersonic": 2077,
                      "timeZeroBoost": 241.51,
                      "percentZeroBoost": 12.361859599999999,
                      "timeFullBoost": 197.31,
                      "percentFullBoost": 10.3483226,
                      "timeBoost0To25": 626.4100000000001,
                      "timeBoost25To50": 403.08,
                      "timeBoost50To75": 376.78999999999996,
                      "timeBoost75To100": 500.08000000000004,
                      "percentBoost0To25": 33.4978464,
                      "percentBoost25To50": 21.5141558,
                      "percentBoost50To75": 19.377444,
                      "percentBoost75To100": 25.610554999999998
                    },
                    "movement": {
                      "avgSpeed": 7844,
                      "totalDistance": 2937685,
                      "timeSupersonicSpeed": 331.95000000000005,
                      "timeBoostSpeed": 800.39,
                      "timeSlowSpeed": 804.01,
                      "timeGround": 1094.55,
                      "timeLowAir": 725.32,
                      "timeHighAir": 116.46000000000001,
                      "timePowerslide": 34.56,
                      "countPowerslide": 405,
                      "avgPowerslideDuration": 0.43,
                      "avgSpeedPercentage": 68.2086948,
                      "percentSlowSpeed": 41.833304600000005,
                      "percentBoostSpeed": 40.9887592,
                      "percentSupersonicSpeed": 17.1779352,
                      "percentGround": 56.586110399999995,
                      "percentLowAir": 37.4779162,
                      "percentHighAir": 5.93597172
                    },
                    "positioning": {
                      "avgDistanceToBall": 14931,
                      "avgDistanceToBallPossession": 13884,
                      "avgDistanceToBallNoPossession": 15956,
                      "avgDistanceToMates": 18973,
                      "timeDefensiveThird": 906.9000000000001,
                      "timeNeutralThird": 623.6399999999999,
                      "timeOffensiveThird": 405.83000000000004,
                      "timeDefensiveHalf": 1247.12,
                      "timeOffensiveHalf": 689.24,
                      "timeBehindBall": 1469.56,
                      "timeInfrontBall": 466.79,
                      "timeMostBack": 588.1,
                      "timeMostForward": 687.7,
                      "goalsAgainstWhileLastDefender": 2,
                      "timeClosestToBall": 621.7,
                      "timeFarthestFromBall": 661.9000000000001,
                      "percentDefensiveThird": 47.7679568,
                      "percentOffensiveThird": 20.143881999999998,
                      "percentNeutralThird": 32.088160800000004,
                      "percentDefensiveHalf": 65.4693336,
                      "percentOffensiveHalf": 34.530670199999996,
                      "percentBehindBall": 76.20927200000001,
                      "percentInfrontBall": 23.7907268,
                      "percentMostBack": 31.0688988,
                      "percentMostForward": 35.1219988,
                      "percentClosestToBall": 32.4925114,
                      "percentFarthestFromBall": 34.509232600000004
                    },
                    "demo": {
                      "inflicted": 2,
                      "taken": 6
                    }
                  },
                  "advanced": {
                    "goalParticipation": 44.44444444444444,
                    "rating": 0.7899229887442882
                  }
                }
              ]
            },
            "number": 17,
            "games": [
              {
                "_id": "60cf95f388116f536df97570",
                "blue": 0,
                "orange": 1,
                "duration": 314,
                "overtime": true,
                "ballchasing": "0acdb9fc-ab50-44aa-bc9b-25acfb390a90"
              },
              {
                "_id": "60cf977088116f536df97577",
                "blue": 0,
                "orange": 1,
                "duration": 300,
                "ballchasing": "6a7437ea-5479-443a-bbb5-ab479c243caf"
              },
              {
                "_id": "60cf986688116f536df9757e",
                "blue": 2,
                "orange": 1,
                "duration": 323,
                "overtime": true,
                "ballchasing": "3177e430-42e2-4478-bb1b-ee6ccedbdb1b"
              },
              {
                "_id": "60cf9b2d67835678df0160bf",
                "blue": 1,
                "orange": 2,
                "duration": 571,
                "overtime": true,
                "ballchasing": "eba29bbd-8f44-4d2e-9fd5-fcaf02973e39"
              },
              {
                "_id": "60cf9d1267835678df0160c6",
                "blue": 0,
                "orange": 4,
                "duration": 300,
                "ballchasing": "3f9bb9c3-efa6-497d-bf17-751173157a99"
              }
            ]
          }
        ]
        """
}

extension Decodable {
    init(data: Data, using decoder: JSONDecoder = .init()) throws {
        self = try decoder.decode(Self.self, from: data)
    }
    init(json: String, using decoder: JSONDecoder = .init()) throws {
        try self.init(data: Data(json.utf8), using: decoder)
    }
}
