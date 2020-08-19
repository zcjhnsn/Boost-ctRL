//
//  TwitchCell.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 2/5/20.
//  Copyright © 2020 Zac Johnson. All rights reserved.
//

import UIKit

class TwitchCell: UICollectionViewCell {
    var streamer: Streamer? {
        didSet {
            guard let streamer = streamer else { return }
			playerLabel.text = streamer.userName
			titleLabel.text = streamer.title
			let viewers = NSAttributedString(string: " \(streamer.viewers)")
			let fullString = NSMutableAttributedString(string: "")
			let imageAttachment = NSTextAttachment()
			imageAttachment.image = UIImage(systemName: "circle.fill")?.withTintColor(.systemRed, renderingMode: .alwaysTemplate)
			let imageString = NSAttributedString(attachment: imageAttachment)
			fullString.append(imageString)
			fullString.append(viewers)
            viewerLabel.attributedText = fullString
        }
    }
	
	var link = "https://twitch.tv"
	
	fileprivate let containerView: UIView = {
		let view = UIView()
		view.usesAutoLayout()
		view.backgroundColor = .clear
		return view
	}()
    
    fileprivate let playerLabel: UILabel = {
        let label = UILabel()
        label.usesAutoLayout()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .white
        label.text = "No one is live right now"
        label.numberOfLines = 1
        return label
    }()
	
	fileprivate let titleLabel: UILabel = {
		let label = UILabel()
		label.usesAutoLayout()
		label.font = .systemFont(ofSize: 15, weight: .regular)
		label.textColor = .systemGray
        label.contentMode = .topLeft
		label.text = "Check back later!"
		label.numberOfLines = 0
		return label
	}()
    
    fileprivate let viewerLabel: UILabel = {
        let label = UILabel()
        label.usesAutoLayout()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.text = ""
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
		
		contentView.addSubview(viewerLabel)
		viewerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
		viewerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        viewerLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true

		contentView.addSubview(containerView)
		containerView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: viewerLabel.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 12))
		
		containerView.addSubview(playerLabel)
		playerLabel.fillParentViewSection(.top)
		containerView.addSubview(titleLabel)
		titleLabel.fillParentViewSection(.bottom)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
