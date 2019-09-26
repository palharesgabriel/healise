//
//  FocusedPhotoViewController.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 24/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class FocusedPhotoViewController: FocusedMediaViewController {
    
    var photos = [UIImage]()
    
    init(row: Int, photos: [UIImage]? = nil) {
        super.init(nibName: nil, bundle: nil)
        collectionView.scrollToItem(at: IndexPath(row: row, section: 0), at: .centeredHorizontally, animated: false)
        focusedImageView.image = CalendarManager.shared.selectedDay.media?.photos?[row]
        
        if let photos = photos {
            self.photos = photos
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension FocusedPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CaptureCollectionViewCell else { return }
        focusedImageView.image = cell.captureImageView.image
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return images.count
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "CaptureCell", for: indexPath) as? CaptureCollectionViewCell else { return UICollectionViewCell()}
        cell.setupCell(image: photos[indexPath.row])
        return cell
    }
}
