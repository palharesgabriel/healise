//
//  CollectionViewJourney.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 15/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class CollectionViewJourney: UITableViewCell, ViewCode {
    
    
    // MARK: Properties
    let  collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CellCollectionViewJourney.self, forCellWithReuseIdentifier: "collectioncell")
        return collection
    }()
    
    
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViewHierarchy()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Functions
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
