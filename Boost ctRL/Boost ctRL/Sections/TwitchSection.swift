//
//  TwitchSection.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 2/6/20.
//  Copyright © 2020 Zac Johnson. All rights reserved.
//

import UIKit

struct TwitchSection: Section {
	
   var numberOfItems: Int = 1
	
	var streamers: [Streamer]? {
		didSet {
			guard let streamers = streamers else { return }
			numberOfItems = streamers.count > 0 ? streamers.count : 1
		}
	}

    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .fractionalHeight(0.2))
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered

        return section
    }

    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TwitchCell.defaultReuseIdentifier, for: indexPath) as! TwitchCell
		if streamers != nil && streamers!.count > 0 {
			cell.streamer = streamers![indexPath.item]
		}
		cell.layer.shouldRasterize = true
		cell.layer.rasterizationScale = UIScreen.main.scale
		return cell
		
    }
	
	func handleSelection(collectionView: UICollectionView, indexPath: IndexPath) -> String {
		return "https://twitch.tv/\(streamers?[indexPath.item].userName ?? "")"
	}
}

