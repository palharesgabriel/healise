//
//  MediaCollectionViewCell.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 28/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell, Shadow {
    
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        contentView.backgroundColor = .clear
        setupView()
    }
    
    func setupCell(imageName: String) {
        if #available(iOS 13.0, *) {
            let configuration = UIImage.SymbolConfiguration(pointSize: 48, weight: .light)
            iconImageView.image = UIImage(systemName: imageName, withConfiguration: configuration)?.withRenderingMode(.alwaysTemplate) ?? UIImage(named: "notes")!.withRenderingMode(.alwaysTemplate)
        } else {
            iconImageView.image =  UIImage(named: "notes")!.withRenderingMode(.alwaysTemplate)
        }
        iconImageView.tintColor = UIColor(named: "TitleColor")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not benn implemented")
    }
    
}

extension MediaCollectionViewCell: ViewCode {
    func buildViewHierarchy() {
        self.contentView.addSubview(iconImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        addShadow(view: self)
    }
}
