//
//  EventDetailView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 8/2/21.
//

import SwiftUI
import Collections

struct EventDetailView: View {
    var eventID: String
    
    @ObservedObject var eventViewModel = EventViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            EventHeaderView(event: eventViewModel.event)
                .redacted(when: eventViewModel.isEventLoading)
            
            EventDetailsView(event: eventViewModel.event)
                .redacted(when: eventViewModel.isEventLoading)
            
            if !eventViewModel.topPerformers.isEmpty {
                TopPerformersHeader()
                
                EventTopPerformersView(performers: eventViewModel.topPerformers)
                    .redacted(when: eventViewModel.isTopPerformersLoading)
            }
            
            if !eventViewModel.participants.isEmpty {
                ParticipantsView(participants: eventViewModel.participants)
                    .redacted(when: eventViewModel.isParticipantsLoading)
            }
            
            
            if !eventViewModel.event.stages.isEmpty {
                EventStagesHeaderView()
                
                EventStagesView(event: eventViewModel.event)
            }
            
            EventMatchesHeaderView()
            
            EventMatchesView(matches: eventViewModel.eventMatches)
                .redacted(when: eventViewModel.isEventMatchesLoading)
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.primaryGroupedBackground)
        .onAppear(perform: {
            eventViewModel.getEvent(byID: eventID)
            eventViewModel.getParticipants(forEvent: eventID)
            eventViewModel.getTopPerformers(forEvent: eventID)
            eventViewModel.getMatches(forEvent: eventID)
        })
    }
}

struct EventHeaderView: View {
    
    var event: EventResult
    
    var body: some View {
        HStack {
            Text(event.name)
                .font(.system(.largeTitle).weight(.bold))
                .foregroundColor(.primary)
            
            
            Spacer()
            
        }
        .padding(.horizontal)
    }
}

struct EventDetailsView: View {
    var event: EventResult
    
    func getReadableDate(from eventDate: Date?) -> String {
        guard let date = eventDate else { return "???" }
        
        return DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
    }
    
    var body: some View {
        Collapsible(text: {
                Text("Details")
                    .font(.system(.title3, design: .default).weight(.semibold))
        }, image: {
            Image(systemName: "info.circle")
        }, iconColor: {
            Color.primary
        }, content: {
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
                            Text("\(getReadableDate(from: event.startDate)) - \(getReadableDate(from: event.endDate))")
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
                            Text(CurrencySymbol.shared.currencyString(for: Decimal(event.prize.amount), isoCurrencyCode: event.prize.currency, dropCents: true))
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
                    
                    Label (
                        title: {
                            Text("\(event.hasLAN() ? "LAN" : "Online")")
                                .font(.system(.subheadline).weight(.regular))
                                .foregroundColor(.primary)
                        },
                        icon: {
                            Image(systemName: "network")
                                .foregroundColor(.gray)
                        }
                    )
                    
//                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal)
        })
        .padding(.vertical)
        .background(Color.secondaryGroupedBackground)
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
                        .font(.system(.title3, design: .default).weight(.bold))
                },
                icon: {
                    Image(systemName: "bolt")
                        .foregroundColor(.yellow)
                }
            )
                .padding(.vertical, 8)
            
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
                        NavigationLink(
                            destination: PlayerScreen(playerID: performer.player.slug),
                            label: {
                                TopPerformerView(performer: performer, index: index)
                                    .foregroundColor(.primary)
                            })
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
    }
}


struct ParticipantsView: View {
    @State var showPlayers: Bool = false
    
    var participants: [Participant]
    
    private var defaultImage: UIImage {
        return UIImage(named: "ctrl-glyph")!
    }
    
    var rows = [
        GridItem(.fixed(120)),
        GridItem(.fixed(120))
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Label {
                    Text("Participants")
                        .font(.system(.title3, design: .default).weight(.bold))
                } icon: {
                    Image(systemName: "car.2.fill")
                        .foregroundColor(.purple)
                }
                
                Spacer()
                
                Text("Players")
                    .font(.system(.caption, design: .default))
                
                Toggle(isOn: $showPlayers) {
                    Text("")
                }
                .toggleStyle(SwitchToggleStyle(tint: .blue))
                .labelsHidden()
                    
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, spacing: 8) {
                    
                    ForEach(participants, id: \.team.id) { participant  in
                        
                        VStack {
                            if showPlayers {
                                ForEach(participant.players, id: \.id) { player in
                                    HStack {
                                        CountryFlagView(countryAbbreviation: player.country)
                                        
                                        Text(player.tag)
                                            .font(.system(.subheadline, design: .default).weight(.light))
                                        
                                        
                                        Spacer()
                                        
                                    }
                                }
                                .transition(.opacity)
                            } else {
                                UrlImageView(urlString: participant.team.image, type: .logo)
                                    .transition(.opacity)
                                
                                Text(participant.team.name)
                                    .font(.system(.subheadline, design: .default).weight(.light))
                                    .transition(.opacity)
                            }
                        }
                        .transition(.opacity)
                        .frame(width: 120)
                        .padding()
                        .background(Color.secondaryGroupedBackground)
                        .cornerRadius(8, corners: .allCorners)
                        
                    }
                }
            }
            .padding(.leading)
            
        }
        .padding(.vertical)
        
    }
}


struct EventMatchesHeaderView: View {
    var body: some View {
        HStack {
            Label {
                Text("Matches")
                    .font(.system(.title3, design: .default).weight(.bold))
            } icon: {
                Image(systemName: "calendar")
                    .foregroundColor(Color.blue)
            }
            
            Spacer()
        }
        .padding(.horizontal)

    }
}


struct EventMatchesView: View {
    var matches: OrderedDictionary<DateComponents, [Match]>
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd MMM yyyy"
        return df
    }()
    
    var body: some View {
        VStack {
            ForEach(matches.keys.sorted(by: { $0.date ?? Date() > $1.date ?? Date() }), id: \.day) { date in
                
                VStack {
                    HStack {
                        Text(Calendar.current.date(from: date)!, formatter: dateFormatter)
                            .font(.system(.body, design: .default).weight(.bold))
                        
                        Spacer()
                    }.padding([.horizontal, .top])
                    
                    ForEach(matches[date]!.sorted(by: { $0.date < $1.date}), id: \.id) { match in
                        MatchCardView(match: match, viewSize: .medium)
                    }
//                    .padding(.horizontal)
                    
                }
                .background(Color(UIColor.systemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                .padding(.horizontal)
            }
        }
    }
}

struct EventStagesHeaderView: View {
    var body: some View {
        HStack {
            Label {
                Text("Stages")
                    .font(.system(.title3, design: .default).weight(.bold))
            } icon: {
                Image(systemName: "flowchart")
                    .foregroundColor(Color.orange)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct EventStagesView: View {
    @Environment(\.openURL) var openURL
    @AppStorage("LinkDestination") var linkDestination = 0
    @State var openInAppBrowser = false
    
    var event: EventResult
    
    var body: some View {
        
        VStack {
            ForEach(event.stages, id: \.id) { stage in
                HStack {
                    Text(stage.name)
                        .padding(8)
                    
                    Spacer()
                    
                    if !stage.liquipedia.isEmpty {
                        Button(action: {
                            if linkDestination == 0 {
                                openInAppBrowser = true
                            } else {
                                openURL(LinkHelper.processLinkForDestination(stage.liquipedia, destination: linkDestination))
                            }
                        }, label: {
                            Image("lp-logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(.horizontal)
                                .padding(.vertical, 2)
                        })
                        .frame(width: 100, height: 40, alignment: .center)
                        .background(Color.liquipediaBlue)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 2)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .sheet(isPresented: $openInAppBrowser, content: {
                            SafariView(url: LinkHelper.processLinkForDestination(stage.liquipedia, destination: linkDestination))
                                .edgesIgnoringSafeArea(.all)
                        })
                        
                    }

                }
                .padding(2)
                .background(Color.secondaryGroupedBackground)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                .padding(.horizontal)
            }
        }
        .padding(.bottom)
    }
}


struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailView(eventID: "609798263dfdaa8e09bfe851")
    }
}

struct EventStagesView_Previews: PreviewProvider {
    static var previews: some View {
        EventStagesView(event: ExampleData.eventResult)
            .preferredColorScheme(.dark)
    }
}
