//
//  GalleryViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 26/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class GalleryViewController: MediaViewController, ViewCode, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	
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
    
    var day = CalendarManager.shared.selectedDay

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
		galleryCollectionView.register(CaptureCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
		galleryCollectionView.register(NewItemGalleryCollectionViewCell.self, forCellWithReuseIdentifier: NewItemGalleryCollectionViewCell.reuseIdentifier)
    }
    
    func buildViewHierarchy() {
        view.addSubviews([galleryCollectionView])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
			galleryCollectionView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 4),
            galleryCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            galleryCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            galleryCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfigurantion() {
    }
}
