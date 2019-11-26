//
//  CollectionTableViewCell.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 15/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell, ViewCode {
    let shadowView = ShadowView()
    
    
    // MARK: Properties
    let iconNames = [(sf: "text.justifyleft", normal: "notes"), (sf: "pencil.and.outline", normal: "pencil"), (sf: "mic", normal: "mic"), (sf: "camera", normal: "camera")]
    
    let  collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isPagingEnabled = true
        collection.backgroundColor = .white
        collection.layer.cornerRadius = 16
        return collection
    }()
    
    
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        collectionView.register(PieChartCollectionViewCell.self, forCellWithReuseIdentifier: "pieChartCell")

        
        NotificationCenter.default.addObserver(self,selector: #selector(deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Functions
    @objc func deviceOrientationDidChange(_ notification: Notification) {
        collectionView.reloadData()
        let orientation = UIDevice.current.orientation
        print(orientation.isLandscape)
    }
    func buildViewHierarchy() {
        addSubviews([shadowView, collectionView])
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            shadowView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            shadowView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            shadowView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
}

extension CollectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pieChartCell", for: indexPath) as? PieChartCollectionViewCell else { return UICollectionViewCell()}
        cell.populateChartView()
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        default:
            break
        }
    }
}

extension CollectionTableViewCell: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        switch UIDevice.current.model {
        case "iPhone":
            return CGSize(width: collectionView.frame.width , height: 300)
        default:
            let portraitSize = CGSize(width: collectionView.frame.width , height: 300)
            let landscapeSize = CGSize(width: collectionView.frame.width, height: 300)
            return UIDevice.current.orientation.isLandscape ? landscapeSize : portraitSize
        }
    }
}
