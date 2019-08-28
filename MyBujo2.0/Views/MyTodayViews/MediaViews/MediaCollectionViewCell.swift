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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not benn implemented")
    }
    
}

extension MediaCollectionViewCell: ViewCode, Shadow {
    func buildViewHierarchy() {
        self.addSubview(iconImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        //
    }
}
