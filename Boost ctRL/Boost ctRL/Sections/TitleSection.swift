//
//  TitleSection.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 2/6/20.
//  Copyright © 2020 Zac Johnson. All rights reserved.
//

import UIKit

struct SectionTitleSection: Section {
	
    let numberOfItems = 1
    private let title: String

    init(title: String) {
        self.title = title
    }

    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        return section
    }

    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCell.defaultReuseIdentifier, for: indexPath) as! TitleCell
		cell.title = title
		cell.layer.shouldRasterize = true
		cell.layer.rasterizationScale = UIScreen.main.scale
        return cell
    }
	
	func handleSelection(collectionView: UICollectionView, indexPath: IndexPath) -> String {
		return ""
	}
}
