//
//  TitleCell.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 2/6/20.
//  Copyright © 2020 Zac Johnson. All rights reserved.
//

import UIKit

final class TitleCell: UICollectionViewCell {
	
	var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
	
	var titleLabel: UILabel = {
		var label = UILabel()
		label.text = "Label"
		label.font = .systemFont(ofSize: 26, weight: .medium)
		label.numberOfLines = 1
		label.contentMode = .left
		label.textColor = .white
		label.usesAutoLayout()
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		
		contentView.addSubview(titleLabel)
		
		titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
		titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
