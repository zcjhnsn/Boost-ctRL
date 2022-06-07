//
//  EventCardView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 6/2/22.
//

import SwiftUI

struct EventCardView: View {
    var event: Event
    
    @State private var showEventDetail: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 4) {
                
                NavigationLink(isActive: $showEventDetail, destination: {
                    EventDetailView(eventID: event.slug)
                }, label: {
                    EmptyView()
                })
                .hidden()
                
                HStack(alignment: .center) {
                    
                    VStack {
                        UrlImageView(urlString: event.image, type: .logo)
                            .padding(4)
                            .background(Color(UIColor.secondarySystemGroupedBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            .frame(width: 44, height: 44, alignment: .center)
                    }
                    
                    Text(event.name)
                        .font(Font.system(.headline).bold())
                    
                    Spacer()

                }
                
                VStack(spacing: 4) {
                    HStack {
                        Text("\(Image(systemName: "flame")) \(Text(event.tier.rawValue).bold())")
                        Spacer()
                        Text("\(Image(systemName: "mappin.and.ellipse")) \(Text(event.region.rawValue).bold())")
                        Spacer()
                        Text("\(Image(systemName: "car")) \(Text("\(event.mode)v\(event.mode)").bold())")
                        Spacer()
                        Text("\(Image(systemName: "network")) \(Text(event.hasLAN() ? "LAN" : "Online").bold())")
                    }
                    .padding(.horizontal, 4)
                    
                    HStack {
                        Text("\(Image(systemName: "calendar")) \(Text(getDate()).bold())")
                        Spacer()
                        Text("\(Image(systemName: "dollarsign.square")) \(Text(CurrencySymbol.shared.currencyString(for: Decimal(event.prize.amount), isoCurrencyCode: event.prize.currency, dropCents: true)).bold())")
                        Spacer()
                    }
                    .padding(.horizontal, 4)
                }
                .font(.system(.subheadline, design: .rounded))
                .padding(4)
                .background(Color.tertiaryGroupedBackground)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                
            }
            .padding()
            .background(Color.secondaryGroupedBackground)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .onTapGesture {
            showEventDetail.toggle()
        }
    }
    
    private func getDate() -> String {
        let startDate = event.startDate?.readable() ?? "???"
        let endDate = event.endDate?.readable() ?? "???"
        
        return startDate + " - " + endDate
    }
}

struct EventCardView_Previews: PreviewProvider {
    static var previews: some View {
        EventCardView(event: ExampleData.event)
            .preferredColorScheme(.light)
        EventCardView(event: ExampleData.event)
            .preferredColorScheme(.dark)
    }
}
