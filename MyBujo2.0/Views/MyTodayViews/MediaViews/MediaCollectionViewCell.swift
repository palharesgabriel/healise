//
//  MediaCollectionViewCell.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 28/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell {
    
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let shadowView = ShadowView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
    
    func setupCell(imageName: String) {
        if #available(iOS 13.0, *) {
            let configuration = UIImage.SymbolConfiguration(pointSize: 48, weight: .light)
            iconImageView.image = UIImage(systemName: imageName, withConfiguration: configuration)?.withRenderingMode(.alwaysTemplate) ?? UIImage(named: "notes")!.withRenderingMode(.alwaysTemplate)
        } else {
            iconImageView.image =  UIImage(named: imageName)!.withRenderingMode(.alwaysTemplate)
        }
        iconImageView.tintColor = UIColor(named: "TitleColor")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not benn implemented")
    }
    
}

extension MediaCollectionViewCell: ViewCode {
    func buildViewHierarchy() {
        self.contentView.addSubview(shadowView)
        self.contentView.addSubview(iconImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            iconImageView.centerXAnchor.constraint(equalTo: shadowView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: shadowView.centerYAnchor)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        shadowView.translatesAutoresizingMaskIntoConstraints = false
    }
}
