//
//  OctaneCell.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 2/6/20.
//  Copyright © 2020 Zac Johnson. All rights reserved.
//

import UIKit

class OctaneCell: UICollectionViewCell {
    
    var article: OctaneArticle? {
        didSet {
            guard let article = article else { return }
			
			link = article.url
            
			title.text = String(htmlEncodedString: article.title)
        }
    }
	
	var link = "https://octane.gg"
    
	let bg: UIImageView = {
        let iv = UIImageView()
        iv.usesAutoLayout()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "octane")
		
        iv.layer.cornerRadius = 12
        iv.backgroundColor = UIColor(red: 46/255.0, green: 63/255.0, blue: 82/255.0, alpha: 1) // #2e3f52
        return iv
    }()
    
    fileprivate let title: UILabel = {
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
		bg.image = UIImage(named:"octaneLogo")
	}
}



class BlankOctaneCell: UICollectionViewCell {
    
    fileprivate let bg: UIImageView = {
        let iv = UIImageView()
        iv.usesAutoLayout()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
		iv.image = UIImage(named:"octaneLogo")
        iv.layer.cornerRadius = 12
		iv.backgroundColor = UIColor(red: 46/255.0, green: 63/255.0, blue: 82/255.0, alpha: 1) // #2e3f52
        return iv
    }()
    
    fileprivate let title: UILabel = {
        let label = UILabel()
        label.usesAutoLayout()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        label.text = "Read More At Octane.gg"
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
		bg.image = UIImage(named: "octaneLogo")
	}
	
	func getLink() -> String {
		return "https://octane.gg"
	}
}
