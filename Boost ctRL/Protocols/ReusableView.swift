//
//  ReusableView.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 2/6/20.
//  Copyright © 2020 Zac Johnson. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableView {}
