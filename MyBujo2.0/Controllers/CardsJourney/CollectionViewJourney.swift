//
//  CollectionViewJourney.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 15/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class CollectionViewJourney: UIView, ViewCode {
    
    // MARK: Properties
    var collectionView: UICollectionView = {
        let collection = UICollectionView()
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame:.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubviews([collectionView])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
        collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        
    }
    
    
}
