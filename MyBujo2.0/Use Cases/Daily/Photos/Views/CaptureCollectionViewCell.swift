//
//  CaptureCollectionViewCell.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 12/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

protocol CaptureCollectionViewCellDelegate: class {
	func didDeleteSelectedCell(selected: UICollectionViewCell)
}

class CaptureCollectionViewCell: UICollectionViewCell, ViewCode {
    
	weak var delegate: CaptureCollectionViewCellDelegate?
	
    let captureImageView: UIImageView = {
       let imgView = UIImageView()
        imgView.isUserInteractionEnabled = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
		imgView.contentMode = .scaleToFill
        return imgView
    }()
	
	let deleteCellButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		if #available(iOS 13.0, *) {
			let trashImage = UIImage(systemName: "trash.circle.fill", compatibleWith: .current)
			let redTrashImage = trashImage?.withTintColor(UIColor(named: "ActionColor")!, renderingMode: .alwaysOriginal)
			button.setBackgroundImage(redTrashImage, for: .normal)
		} else {
			button.setImage(UIImage(named: "camerabubble"), for: .normal)
		}
		return button
	}()
	
	var editable: Bool = false
    
	func setupCell(image: UIImage) {
        setupView()
		deleteCellButton.isHidden = true
		captureImageView.image = image
		deleteCellButton.addTarget(self, action: #selector(deleteCell), for: .touchDown)
	}
    
    func buildViewHierarchy() {
		
        addSubview(captureImageView)
		addSubview(deleteCellButton)
		
	}
    
	func setupConstraints() {
        NSLayoutConstraint.activate([
            captureImageView.topAnchor.constraint(equalTo: topAnchor),
            captureImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            captureImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            captureImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
		
		NSLayoutConstraint.activate([
			deleteCellButton.widthAnchor.constraint(equalToConstant: 30),
			deleteCellButton.heightAnchor.constraint(equalToConstant: 30),
			deleteCellButton.topAnchor.constraint(equalTo: topAnchor),
			deleteCellButton.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
    }
	
	
	@objc func deleteCell() {
		delegate?.didDeleteSelectedCell(selected: self)
	}
	
    func setupAdditionalConfigurantion() {
        backgroundColor = .white
    }
}
