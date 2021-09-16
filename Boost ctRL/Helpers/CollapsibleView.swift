//
//  CollapsibleView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/30/21.
//

import SwiftUI

struct Collapsible<Content: View>: View {
    @State var label: () -> Text
    @State var content: () -> Content
    
    @State private var collapsed: Bool = false
    
    var body: some View {
        VStack {
            Button(
                action: {
                    withAnimation {
                        self.collapsed.toggle()
                    }
                },
                label: {
                    HStack {
                        self.label()
                        Spacer()
                        Image(systemName: "chevron.up")
                            .rotationEffect(.degrees(collapsed ? 180 : 0))
                    }
                    .padding(.bottom, 1)
                    .background(Color.clear)
                }
            )
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal)
            
                VStack {
                    self.content()
                        .opacity(collapsed ? 0 : 1)
                        .animation(.easeInOut)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none)
                .clipped()
        }
        
    }
}
