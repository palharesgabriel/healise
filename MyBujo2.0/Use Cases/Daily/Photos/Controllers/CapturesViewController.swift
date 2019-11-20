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

	var canEdit: Bool = false
	
	lazy var editGalleryBarButtomItem = UIBarButtonItem(title: "Editar", style: .plain, target: self, action: #selector(shouldEnableEditGallery))
	
	override func viewWillAppear(_ animated: Bool) {
		self.title = "Fotos"
		let addPhotoBarButtomItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentImagePickerController))
		navigationItem.setRightBarButtonItems([addPhotoBarButtomItem, editGalleryBarButtomItem], animated: true)
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		galleryCollectionView.dataSource = self
		galleryCollectionView.delegate = self
	}
	
	@objc func shouldEnableEditGallery() {
		canEdit = !canEdit
		if canEdit {
			enableEdit()
		} else {
			disableEdit()
		}
	}
	
	func enableEdit() {
		editGalleryBarButtomItem.title = "Cancelar"
		for cell in galleryCollectionView.visibleCells {
			guard let captureCell = cell as? CaptureCollectionViewCell else { continue }
			captureCell.editable = true
			captureCell.shake()
		}
	}
	
	func disableEdit() {
		editGalleryBarButtomItem.title = "Editar"
		for cell in galleryCollectionView.visibleCells {
			guard let captureCell = cell as? CaptureCollectionViewCell else { continue }
			captureCell.editable = false
			captureCell.stopShake()
		}
	}
}

extension CapturesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard let media = day.media, let photos = media.photos else { return 1 }
		return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CaptureCollectionViewCell else { return UICollectionViewCell()}
		cell.delegate = self
		guard let media = day.media, let images = media.photos else { return UICollectionViewCell()}
		cell.setupCell(image: images[indexPath.row])
		return cell
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
			disableEdit()
        default:
            let testController = FocusedPhotoViewController(row: indexPath.row, photos: CalendarManager.shared.selectedDay.media?.photos)
            present(testController, animated: true, completion: nil)
        }
    }
}

extension CapturesViewController: CaptureCollectionViewCellDelegate {
	func didDeleteSelectedCell(selected: UICollectionViewCell) {
		let indexPath = galleryCollectionView.indexPath(for: selected)
        if (day.media?.remove(index: indexPath!.row, mediaPath: (day.media?.photosPath)!))! {
			galleryCollectionView.deleteItems(at: [indexPath!])
		}
	}
}
