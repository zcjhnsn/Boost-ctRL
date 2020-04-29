//
//  OctaneSection.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 2/6/20.
//  Copyright © 2020 Zac Johnson. All rights reserved.
//

import UIKit

struct OctaneSection: Section {
	var numberOfItems: Int = 1
	
	var articles: [OctaneArticle]? {
        didSet {
            guard let articles = articles else { return }
			numberOfItems = articles.count
        }
    }
	

    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .fractionalHeight(0.35))
//		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered

        return section
    }

    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
		if let articles = articles {
			if indexPath.row == articles.count - 1 {
				let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BlankOctaneCell.defaultReuseIdentifier, for: indexPath) as! BlankOctaneCell
				return cell
			} else {
				let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OctaneCell.defaultReuseIdentifier, for: indexPath) as! OctaneCell
				cell.article = articles[indexPath.item]
                let splitURL = articles[indexPath.item].image.components(separatedBy: ".jpg")
                let url = splitURL[0] + "l.jpg"
				cell.bg.loadImageFromCacheWithUrlString(urlString: url, withPlaceholder: "octaneLogo")
				return cell
			}
		} else {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BlankOctaneCell.defaultReuseIdentifier, for: indexPath) as! BlankOctaneCell
			cell.placeholder = "Loading..."
			return cell
		}
    }
	
	func handleSelection(collectionView: UICollectionView, indexPath: IndexPath) -> String {
		if let articles = articles {
			var link = "https://octane.gg/news/"
			if indexPath.row == articles.count - 1 {
				link = "https://octane.gg"
			} else {
				link += articles[indexPath.row].url
				
			}
			
			return link
		}
		return "https://octane.gg"
	}
}

