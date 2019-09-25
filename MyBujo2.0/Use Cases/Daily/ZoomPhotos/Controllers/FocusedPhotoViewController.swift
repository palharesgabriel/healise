//
//  FocusedPhotoViewController.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 24/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class FocusedPhotoViewController: FocusedMediaViewController {
    
    init(row: Int) {
        super.init(nibName: nil, bundle: nil)
        collectionView.scrollToItem(at: IndexPath(row: row, section: 0), at: .centeredHorizontally, animated: false)
        focusedImageView.image = CalendarManager.shared.selectedDay.media?.photos?[row]
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
        guard let photos =  CalendarManager.shared.selectedDay.media?.photos else { return 0 }
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "CaptureCell", for: indexPath) as? CaptureCollectionViewCell else { return UICollectionViewCell()}
        if let photos = CalendarManager.shared.selectedDay.media?.photos {
            cell.setupCell(image: photos[indexPath.row])
        }
        return cell
    }
}
