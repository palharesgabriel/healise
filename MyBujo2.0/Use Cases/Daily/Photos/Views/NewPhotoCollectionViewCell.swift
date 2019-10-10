//
//  NewPhotoCollectionViewCell.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 23/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import UIKit

class NewItemGalleryCollectionViewCell: UICollectionViewCell, ViewCode {
	static let reuseIdentifier = "NewItemGalleryCollectionViewCell"
	let addItemImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.isUserInteractionEnabled = true
		return imageView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	func setupCell (sfImage: String, image: String) {
		if #available(iOS 13.0, *) {
			addItemImageView.image = UIImage(systemName: sfImage, compatibleWith: .current)
			addItemImageView.contentMode = .scaleAspectFill
			addItemImageView.tintColor = UIColor(named: "ActionColor")
		} else {
			addItemImageView.image = UIImage(named: image)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func buildViewHierarchy() {
		addSubview(addItemImageView)
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			addItemImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
			addItemImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
			addItemImageView.widthAnchor.constraint(equalToConstant: 80),
			addItemImageView.heightAnchor.constraint(equalToConstant: 80)
		])
		
	}
	
	func setupAdditionalConfigurantion() {
		
	}
}
