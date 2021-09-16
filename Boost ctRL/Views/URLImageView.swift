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
        Image(uiImage: urlImageModel.image ?? defaultImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
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

extension CGImage {
    var brightness: Double {
        get {
            let imageData = self.dataProvider?.data
            let ptr = CFDataGetBytePtr(imageData)
            var x = 0
            var result: Double = 0
            for _ in 0..<self.height {
                for _ in 0..<self.width {
                    let r = ptr![0]
                    let g = ptr![1]
                    let b = ptr![2]
                    result += (0.299 * Double(r) + 0.587 * Double(g) + 0.114 * Double(b))
                    x += 1
                }
            }
            let bright = result / Double (x)
            return bright
        }
    }
}
extension UIImage {
    var brightness: Double {
        get {
            return (self.cgImage?.brightness)!
        }
    }
}
