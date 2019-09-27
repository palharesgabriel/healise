//
//  PhotosViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 10/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit
import Photos


class CapturesViewController: GalleryViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
		
		galleryCollectionView.dataSource = self
		galleryCollectionView.delegate = self
    }
}

extension CapturesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard let media = day.media, let photos = media.photos else { return 1 }
		return photos.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewItemGalleryCollectionViewCell.reuseIdentifier, for: indexPath) as? NewItemGalleryCollectionViewCell else { return UICollectionViewCell()}
			cell.setupCell(sfImage: "video.circle.fill", image: "videoBubble")
			return cell
        default:
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CaptureCollectionViewCell else { return UICollectionViewCell()}
			guard let images = day.media!.photos else { return UICollectionViewCell()}
			cell.setupCell(image: images[indexPath.row - 1])
            return cell
        }
    }
}

extension CapturesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
			return CGSize(width: view.frame.width * 0.33, height: view.frame.width * 0.33)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            presentImagePickerController()
        default:
            let testController = FocusedPhotoViewController(row: indexPath.row - 1, photos: CalendarManager.shared.selectedDay.media?.photos)
            present(testController, animated: true, completion: nil)
        }
    }
}
