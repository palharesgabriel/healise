//
//  MediaCollectionViewCell.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 28/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell, Shadow {
    
    let shadowView = ShadowView()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameMedia: UILabel = {
        let lbl = UILabel(text: "media", font: .medium, textColor: .titleColor)
        return lbl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        contentView.backgroundColor = .clear
        shadowView.layer.borderWidth = 2
        shadowView.layer.borderColor = UIColor.clear.cgColor
        setupView()
    }
    
    func setupCell(imageName: String, mediaName: String, validateMedia: Bool) {
        if #available(iOS 13.0, *) {
            let configuration = UIImage.SymbolConfiguration(pointSize: 48, weight: .light)
            iconImageView.image = UIImage(systemName: imageName, withConfiguration: configuration)?.withRenderingMode(.alwaysTemplate) ?? UIImage(named: "notes")!.withRenderingMode(.alwaysTemplate)
        } else {
            iconImageView.image =  UIImage(named: imageName)!.withRenderingMode(.alwaysTemplate)
        }
        iconImageView.tintColor = .titleColor
        
        nameMedia.text = mediaName
        if validateMedia == true {
            shadowView.layer.borderColor = UIColor(named: "SelectionColor")?.cgColor
        }
    }
	
	func showShadow(_ bool: Bool) {
		if bool {
			shadowView.layer.borderWidth = 2
		    shadowView.layer.borderColor = UIColor(named: "SelectionColor")?.cgColor
		} else {
			shadowView.layer.borderWidth = 0
		}
	}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not benn implemented")
    }
}

extension MediaCollectionViewCell: ViewCode {
    func buildViewHierarchy() {
        contentView.addSubview(shadowView)
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(nameMedia)
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            iconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameMedia.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameMedia.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        backgroundColor = .clear
    }
}
