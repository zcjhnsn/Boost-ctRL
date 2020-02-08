//
//  RocketeersCell.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 2/6/20.
//  Copyright © 2020 Zac Johnson. All rights reserved.
//

import UIKit

class RocketeersCell: UICollectionViewCell {
    
    var article: RocketeersArticle? {
        didSet {
            guard let article = article else { return }
			link = article.link
            title.text = String(htmlEncodedString: article.title.rendered)
        }
    }
	
	var link = "https://rocketeers.gg"
    
	let bg: UIImageView = {
        let iv = UIImageView()
        iv.usesAutoLayout()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "rocketeersLogo")
		
        iv.layer.cornerRadius = 12
		//iv.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        iv.backgroundColor = UIColor(red: 0/255.0, green: 34/255.0, blue: 51/255.0, alpha: 1)
        return iv
    }()
    
     let title: UILabel = {
        let label = UILabel()
        label.usesAutoLayout()
		label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.textColor = .white
        label.text = "Loading..."
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(bg)
		
//		contentView.backgroundColor = .black
		contentView.backgroundColor = ctRLTheme.midnightBlue
		contentView.clipsToBounds = true
		//contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        bg.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        bg.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 2/3).isActive = true

        
        contentView.addSubview(title)
        title.topAnchor.constraint(equalTo: bg.bottomAnchor, constant: 8).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        //title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
	
//        title.fillParentViewSection(.bottom)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	deinit {
		bg.image = #imageLiteral(resourceName: "rocketeersLogo")
	}
}



class BlankRocketeersCell: UICollectionViewCell {
	
	var placeholder: String? {
		didSet {
			title.text = placeholder
		}
	}
    
    fileprivate let bg: UIImageView = {
        let iv = UIImageView()
        iv.usesAutoLayout()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
		iv.image = UIImage(named: "rocketeersLogo")
        iv.layer.cornerRadius = 12
		//iv.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		iv.backgroundColor = UIColor(red: 0/255.0, green: 34/255.0, blue: 51/255.0, alpha: 1.0) // #002233
        return iv
    }()
    
    fileprivate let title: UILabel = {
        let label = UILabel()
        label.usesAutoLayout()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        label.text = "Read More At Rocketeers.gg"
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(bg)
		
//		contentView.backgroundColor = .black
		contentView.backgroundColor = ctRLTheme.midnightBlue
		contentView.clipsToBounds = true
		contentView.layer.cornerRadius = 12
		//contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        bg.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        bg.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 2/3).isActive = true

        
        contentView.addSubview(title)
        title.topAnchor.constraint(equalTo: bg.bottomAnchor, constant: 8).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        //title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
	
//        title.fillParentViewSection(.bottom)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	deinit {
		bg.image = #imageLiteral(resourceName: "rocketeersLogo")
	}
	
	func getLink() -> String {
		return "https://rocketeers.gg"
	}
}
