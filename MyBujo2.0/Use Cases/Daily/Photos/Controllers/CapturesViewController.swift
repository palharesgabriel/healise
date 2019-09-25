//
//  PhotosViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 10/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit
import Photos

class CapturesViewController: MediaViewController, ViewCode, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let photosCollectionView:UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
		flowLayout.minimumLineSpacing = 1
		flowLayout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    var day = CalendarManager.shared.selectedDay!
	
	lazy var photos: [UIImage]? = {
		guard let media = day.media, let photos = media.photos else { return nil }
		return photos
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
		photosCollectionView.register(CaptureCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
		photosCollectionView.register(NewPhotoCollectionViewCell.self, forCellWithReuseIdentifier: "NewPhotoCollectionViewCell")
        
		photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
	
    }
    
    func buildViewHierarchy() {
        view.addSubview(photosCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        photosCollectionView.backgroundColor = .white
    }
    
//	func sortPhotos () {
//		paths.sort { (firstPath, secondPath) -> Bool in
//			guard let firstDate = getCreatedDateFromFile(path: firstPath) else { return false }
//			guard let secondDate = getCreatedDateFromFile(path: secondPath) else { return false }
//			if firstDate > secondDate {
//				return true
//			}
//			return false
//		}
//	}
}

extension CapturesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard let media = day.media, let photos = media.photos else { return 1 }
		return photos.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewPhotoCollectionViewCell", for: indexPath) as? NewPhotoCollectionViewCell else { return UICollectionViewCell()}

            return cell
        default:
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CaptureCollectionViewCell else { return UICollectionViewCell()}
            guard let image = photos else { return UICollectionViewCell()}
			cell.setupCell(image: image[indexPath.row])
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
            let testController = FocusedPhotoViewController(with: [UIImage()])
            present(testController, animated: true, completion: nil)
        }
    }
}
