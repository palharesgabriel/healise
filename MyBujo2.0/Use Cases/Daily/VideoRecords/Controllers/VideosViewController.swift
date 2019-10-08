//
//  VideoRecordViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 26/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class VideoRecordViewController: GalleryViewController {
	
    override func viewDidLoad() {
        super.viewDidLoad()
		galleryCollectionView.delegate = self
		galleryCollectionView.dataSource = self
	}
}

extension VideoRecordViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewItemGalleryCollectionViewCell.reuseIdentifier, for: indexPath) as? NewItemGalleryCollectionViewCell else { return UICollectionViewCell() }
		cell.setupCell(sfImage: "video.circle.fill", image: "videoBubble")
		return cell
	}
}

extension VideoRecordViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width * 0.33, height: view.frame.width * 0.33)
	}
}
