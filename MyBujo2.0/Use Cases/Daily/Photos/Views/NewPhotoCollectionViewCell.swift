//
//  NewPhotoCollectionViewCell.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 23/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import UIKit

class NewPhotoCollectionViewCell: UICollectionViewCell, ViewCode {
	
	let addPhotoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.isUserInteractionEnabled = true
		if #available(iOS 13.0, *) {
			imageView.image = UIImage(systemName: "camera.circle.fill", compatibleWith: .current)
			imageView.contentMode = .scaleAspectFill
			imageView.tintColor = UIColor(named: "ActionColor")
		} else {
			imageView.image = UIImage(named: "camerabubble")
		}
		return imageView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func buildViewHierarchy() {
		addSubview(addPhotoImageView)
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			addPhotoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
			addPhotoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
			addPhotoImageView.widthAnchor.constraint(equalToConstant: 80),
			addPhotoImageView.heightAnchor.constraint(equalToConstant: 80)
		])
		
	}
	
	func setupAdditionalConfigurantion() {
		
	}
}
