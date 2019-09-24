//
//  ShowViewController.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 24/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class FocusedMediaViewController: UIViewController {
    
    var focusedImageView = UIImageView()
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CaptureCollectionViewCell.self, forCellWithReuseIdentifier: "CaptureCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    func setupHierarchy() {
        view.addSubviews([focusedImageView, collectionView])
    }
    
    func setupConstraints() {
        focusedImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            focusedImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            focusedImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            focusedImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            focusedImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
            
            collectionView.topAnchor.constraint(equalTo: focusedImageView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: focusedImageView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: focusedImageView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
