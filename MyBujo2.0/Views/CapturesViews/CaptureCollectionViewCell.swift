//
//  CaptureCollectionViewCell.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 12/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class CaptureCollectionViewCell: UICollectionViewCell, ViewCode, Shadow {
    
    let captureImageView: UIImageView = {
       let imgView = UIImageView()
        imgView.isUserInteractionEnabled = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    func setupCell(image: UIImage) {
        setupView()
        captureImageView.image = image
        addShadow(view: self)
    }
    
    func buildViewHierarchy() {
        addSubview(captureImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            captureImageView.topAnchor.constraint(equalTo: topAnchor),
            captureImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            captureImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            captureImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        backgroundColor = .white
    }
}
