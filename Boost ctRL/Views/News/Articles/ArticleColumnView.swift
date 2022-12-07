//
//  ArticleColumnView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 7/9/21.
//

import SwiftUI

struct ArticleColumnView: View {
    @ObservedObject var viewModel: ArticlesViewModel
    
    var cols = [GridItem(.adaptive(minimum: 350))]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: cols, alignment: .leading, spacing: 8) {
                ForEach(viewModel.articles) { article in
                    
                        ArticleCardView(article: article)
                            .padding(.horizontal)
                            .redacted(when: viewModel.isShiftLoading)
                            .animation(.easeInOut, value: viewModel.isShiftLoading)
                            
                    
                }
            }
        }
    }
    
    func actionSheet(article: Article) {
        guard let urlShare = URL(string: article.link) else { return }
        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
}

struct ArticleColumnView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleColumnView(viewModel: ArticlesViewModel())
    }
}
