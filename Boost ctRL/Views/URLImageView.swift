//
//  URLImageView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/13/21.
//

import SwiftUI

enum ImageType {
    case logo
    case news
}

struct UrlImageView: View {
    @ObservedObject var urlImageModel: UrlImageModel
    let imageType: ImageType
    
    init(urlString: String? = nil, type: ImageType) {
        urlImageModel = UrlImageModel(urlString: urlString)
        imageType = type
    }
    
    var body: some View {
        if urlImageModel.image == nil {
            Image(uiImage: defaultImage)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.gray)
        } else {
            Image(uiImage: urlImageModel.image!)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
    
    var defaultImage: UIImage {
        if imageType == .news {
            return UIImage(named: "rl-default")!
        } else {
            return UIImage(named: "ctrl-glyph")!
        }
    }
}

struct UrlImageView_Previews: PreviewProvider {
    static var previews: some View {
        UrlImageView(urlString: nil, type: .logo)
    }
}
