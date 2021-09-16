//
//  EventDetailView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 8/2/21.
//

import SwiftUI

struct EventDetailView: View {
    var eventID: String
    
    @ObservedObject var eventViewModel = EventViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            EventHeaderView(event: eventViewModel.event)
            
            EventDetailsView(event: eventViewModel.event)
                .redacted(when: eventViewModel.isEventLoading)
            
            TopPerformersHeader()
            
            EventTopPerformersView(performers: eventViewModel.topPerformers)
                .redacted(when: eventViewModel.isTopPerformersLoading)
        }
        .onAppear(perform: {
            eventViewModel.getEvent(byID: eventID)
            eventViewModel.getTopPerformers(forEvent: eventID)
        })
    }
}

struct EventHeaderView: View {
    
    var event: EventResult
    
    var body: some View {
        HStack {
            Text(event.name)
                .font(.system(.title3).weight(.bold))
                .foregroundColor(.primary)

            
            Spacer()
            
        }
        .padding(.horizontal)
    }
}

struct EventDetailsView: View {
    var event: EventResult
    
    var body: some View {
        Collapsible {
            Text("Details")
                .font(.system(.title3, design: .default).weight(.semibold))
        } content: {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Label(
                        title: {
                            Text(event.getRegionName())
                                .font(.system(.subheadline).weight(.regular))
                                .foregroundColor(.primary)
                        },
                        icon: {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.red)
                            
                        }
                    )
                    
                    Label(
                        title: {
                            Text("\(DateFormatter.localizedString(from: event.startDate, dateStyle: .short, timeStyle: .none)) - \(DateFormatter.localizedString(from: event.endDate, dateStyle: .short, timeStyle: .none))")
                                .font(.system(.subheadline).weight(.regular))
                                .foregroundColor(.primary)
                        },
                        icon: {
                            Image(systemName: "calendar")
                                .foregroundColor(.blue)
                        }
                    )
                    
                    Label(
                        title: {
                            Text("\(event.prize.amount) \(event.prize.currency.uppercased())")
                                .font(.system(.subheadline).weight(.regular))
                                .foregroundColor(.primary)
                        },
                        icon: {
                            Image(systemName: "dollarsign.square")
                                .foregroundColor(.green)
                        }
                    )
                }
                
                Divider()
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    
                    Label (
                        title: {
                            Text("\(event.mode)v\(event.mode)")
                                .font(.system(.subheadline).weight(.regular))
                                .foregroundColor(.primary)
                        },
                        icon: {
                            Image(systemName: "car")
                                .foregroundColor(.purple)
                        }
                    )
                    
                    Label (
                        title: {
                            Text("\(event.tier) Tier")
                                .font(.system(.subheadline).weight(.regular))
                                .foregroundColor(.primary)
                        },
                        icon: {
                            Image(systemName: "flame")
                                .foregroundColor(.orange)
                        }
                    )
                    
                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal)
            
        }
        .padding(.vertical)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .padding(.horizontal)

    }
}

struct TopPerformersHeader: View {
    
    var body: some View {
        HStack {
            Label(
                title: {
                    Text("Top Performers")
                        .font(.system(.title3, design: .default).weight(.semibold))
                },
                icon: {
                    Image(systemName: "bolt")
                        .foregroundColor(.yellow)
                }
            )
            
            Spacer()
        }
        .padding([.horizontal])
        .padding(.vertical, 6)
    }
}

struct EventTopPerformersView: View {
    var performers: [TopPerformer]
    
    var body: some View {
        VStack {
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Array(zip(performers.indices, performers)), id: \.0) { index, performer in
                        TopPerformerView(performer: performer, index: index)
                    }
                }
            }
        }
    }
}

struct TopPerformerView: View {
    var performer: TopPerformer
    var index: Int
    
    var color: Color {
        switch index {
        case 0:
            return .gold
        case 1:
            return .silver
        case 2:
            return .bronze
        default:
            return .secondary
        }
    }
    
    var isPodium: Bool {
        return index < 3
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // Colored title
            Label(
                title: {
                    Text(performer.player.tag)
                        .font(.system(.headline, design: .rounded).weight(isPodium ? .semibold : .light))
                        .foregroundColor(color)
                },
                icon: {
                    Image(systemName: isPodium ? "star.circle.fill" : "\(index + 1).circle")
                        .foregroundColor(color)
                }
            )
            
            Text(calculateRating())
                .font(.system(.title, design: .default).weight(.semibold))
            
            Text(performer.teams[0].name)
                .font(.system(.subheadline, design: .default).weight(.light))

        }
        .cornerRadius(8)
        .padding(.leading, index == 0 ? 16 : 8)
        .padding(.trailing, 8)
    }
    
    func calculateRating() -> String {
        let totalGames = Double(performer.games.total)
        let cumulativeRating = performer.stats.rating
        let ratingPerGame = cumulativeRating / totalGames
        
        return "\(((ratingPerGame * 1000).rounded(.toNearestOrEven) / 1000))"
        
//        return String(format: "%.3f", ratingPerGame)
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailView(eventID: "609798263dfdaa8e09bfe851")
    }
}
