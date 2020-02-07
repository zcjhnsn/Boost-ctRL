//
//  RocketeersSection.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 2/6/20.
//  Copyright © 2020 Zac Johnson. All rights reserved.
//

import UIKit

struct RocketeersSection: Section {
	var numberOfItems: Int = 1
	
	var articles: [RocketeersArticle]? {
        didSet {
            guard let articles = articles else { return }
			numberOfItems = articles.count + 1
        }
    }
	

    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .fractionalHeight(0.35))
        //let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered

        return section
    }

    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
		if let articles = articles {
			if indexPath.row == articles.count {
				let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BlankRocketeersCell.defaultReuseIdentifier, for: indexPath) as! BlankRocketeersCell
				
				return cell
			} else {
				let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketeersCell.defaultReuseIdentifier, for: indexPath) as! RocketeersCell
				
                cell.article = articles[indexPath.item]
                
                let imageLink = String(articles[indexPath.item].embedded.wpFeaturedmedia[0].mediaDetails.sizes.large.sourceURL)
                if let imageLink = String(htmlEncodedString: imageLink) {
					cell.bg.loadImageFromCacheWithUrlString(urlString: imageLink, withPlaceholder: "rocketeersLogo")
                }
				
				return cell
			}
		} else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BlankRocketeersCell.defaultReuseIdentifier, for: indexPath) as! BlankRocketeersCell
            
            return cell
		}
    }
	
	func handleSelection(collectionView: UICollectionView, indexPath: IndexPath) -> String {
		if let articles = articles {
			var link = ""
			if indexPath.row == articles.count - 1 {
				link = "https://rocketeers.gg"
			} else {
				link = articles[indexPath.item].link
			}
			
			return link
		}
		
		return "https://rocketeers.gg"
	}
}

