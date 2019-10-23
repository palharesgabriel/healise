//
//  GalleryViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 26/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class GalleryViewController: MediaViewController, ViewCode, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
	
	let editGalleryButton: UIButton = {
		let button = UIButton()
		button.setTitle("Edit", for: .normal)
		button.setTitleColor(UIColor(named: "ActionColor"), for: .normal)
		button.layer.cornerRadius = 15
		button.clipsToBounds = true
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
    let galleryCollectionView:UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
		flowLayout.minimumLineSpacing = 1
		flowLayout.minimumInteritemSpacing = 1
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    var day = CalendarManager.shared.selectedDay!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
		galleryCollectionView.register(CaptureCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
		galleryCollectionView.register(NewItemGalleryCollectionViewCell.self, forCellWithReuseIdentifier: NewItemGalleryCollectionViewCell.reuseIdentifier)
    }
    
    func buildViewHierarchy() {
        view.addSubviews([editGalleryButton, galleryCollectionView])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
			editGalleryButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
			editGalleryButton.heightAnchor.constraint(equalToConstant: 40),
			editGalleryButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//			editGalleryButton.widthAnchor.constraint(equalToConstant: 80),
			
			galleryCollectionView.topAnchor.constraint(equalTo: editGalleryButton.bottomAnchor, constant: 4),
            galleryCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            galleryCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            galleryCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfigurantion() {
    }
}
