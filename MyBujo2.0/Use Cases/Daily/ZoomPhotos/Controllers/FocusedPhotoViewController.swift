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
    var row = 0
    
    init(row: Int, photos: [UIImage]? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.row = row
//        focusedImageView.image = CalendarManager.shared.selectedDay.media?.photos?[row]
        
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
        focusedCollectionView.delegate = self
        focusedCollectionView.dataSource = self
        collectionView.scrollToItem(at: IndexPath(row: row, section: 0), at: .centeredVertically, animated: false)
        aditionalConfiguration()
    }
    
    func aditionalConfiguration() {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.close, target: self, action: #selector(backButtonClicked(sender:)))
        let shareButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareImage))
        navigationItem.setRightBarButton(shareButtonItem, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = false
//        navigationController?.navigationBar.tintColor = UIColor(named: "ActionColor")
        navigationItem.setLeftBarButton(button, animated: false)
        navigationItem.setRightBarButton(shareButtonItem, animated: false)
    }
    
    @objc func shareImage() {
        guard let indexPath = focusedCollectionView.indexPathsForVisibleItems.first else { return }
        guard let cell = focusedCollectionView.cellForItem(at: indexPath) as? CaptureCollectionViewCell else { return }
        guard let image = cell.captureImageView.image else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
}

extension FocusedPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        row = indexPath.row
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        focusedCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
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
