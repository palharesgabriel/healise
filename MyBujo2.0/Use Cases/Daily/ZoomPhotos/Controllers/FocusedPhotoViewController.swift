//
//  FocusedPhotoViewController.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 24/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class FocusedPhotoViewController: FocusedMediaViewController {
    let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipe(sender:)))
    var photos = [UIImage]()
    var row = 0
    
    init(row: Int, photos: [UIImage]? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.row = row
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
        collectionView.scrollToItem(at: IndexPath(row: row, section: 0), at: .centeredVertically, animated: false)
        aditionalConfiguration()
        view.addGestureRecognizer(swipeGesture)
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
        guard let image = focusedImageView.image else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    @objc func swipe(sender: UISwipeGestureRecognizer) {
        print("")
        switch sender.direction {
        case .right:
            if row + 1 < photos.count {
                row += 1
                collectionView.scrollToItem(at: IndexPath(row: row, section: 0), at: .centeredHorizontally, animated: true)
                focusedImageView.image = photos[row]
            }
        case .left:
            if row - 1 >= 0 {
                row -= 1
                collectionView.scrollToItem(at: IndexPath(row: row, section: 0), at: .centeredHorizontally, animated: true)
                focusedImageView.image = photos[row]
            }
        default:
            break
        }
    }
    
}

extension FocusedPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CaptureCollectionViewCell else { return }
        focusedImageView.image = cell.captureImageView.image
        row = indexPath.row
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
