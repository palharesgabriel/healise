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
    let formatStringEdit = NSLocalizedString("Edit",
    comment: "Edit")
    lazy var editGalleryBarButtomItem = UIBarButtonItem(title: self.formatStringEdit, style: .plain, target: self, action: #selector(shouldEnableEditGallery))
    weak var delegateTarget: MediaCollectionViewTargetDelegate?
    
	override func viewWillAppear(_ animated: Bool) {
		localizableLabel()
		let addPhotoBarButtomItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentImagePickerController))
		navigationItem.setRightBarButtonItems([addPhotoBarButtomItem, editGalleryBarButtomItem], animated: true)
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		galleryCollectionView.dataSource = self
		galleryCollectionView.delegate = self
	}
	func localizableLabel() {
        let formatStringGoalLabel = NSLocalizedString("Captures",
                                             comment: "Captures")
        self.title = String.localizedStringWithFormat(formatStringGoalLabel)
    }
	@objc func shouldEnableEditGallery() {
		canEdit = !canEdit
		if canEdit {
			enableEdit()
		} else {
			disableEdit()
		}
	}
    
    override func viewWillDisappear(_ animated: Bool) {
        delegateTarget?.mediaTarget()
    }
	func enableEdit() {
        let formatStringCancel = NSLocalizedString("Cancel",
        comment: "Cancel")
		editGalleryBarButtomItem.title = formatStringCancel
		for cell in galleryCollectionView.visibleCells {
			guard let captureCell = cell as? CaptureCollectionViewCell else { continue }
			captureCell.editable = true
			captureCell.shake()
		}
	}
	
	func disableEdit() {
        let formatStringEdit = NSLocalizedString("Edit",
        comment: "Edit")
		editGalleryBarButtomItem.title = formatStringEdit
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
		let testController = FocusedPhotoViewController(row: indexPath.row, photos: CalendarManager.shared.selectedDay.media?.photos)
        present(CustomNavigationController(rootViewController: testController), animated: true, completion: nil)
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
