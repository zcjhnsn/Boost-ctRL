//
//  ChangeLogView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/13/21.
//

import SwiftUI
import MarkdownUI

struct ChangeLogView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
            ScrollView(.vertical) {
                Markdown(
                    #"""
                    It's very easy to make some words **bold** and other words *italic* with Markdown.🙏

                    **Want to experiment with Markdown?** Play with the [reference CommonMark
                    implementation](https://spec.commonmark.org/dingus/).
                    """#
                )
                .padding(.horizontal, 10)
                
                Spacer()
            }
        
    }
}

struct ChangeLogView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeLogView()
    }
}
