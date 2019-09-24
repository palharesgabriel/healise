//
//  FocusedPhotoViewController.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 24/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class FocusedPhotoViewController: FocusedMediaViewController {
    
    var images: [UIImage]!
    
    init(with images: [UIImage]) {
        self.images = images
        super.init(nibName: nil, bundle: nil)
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "CaptureCell", for: indexPath) as? CaptureCollectionViewCell else { return UICollectionViewCell()}
        cell.setupCell(image: images[indexPath.row])
        return cell
    }
}
