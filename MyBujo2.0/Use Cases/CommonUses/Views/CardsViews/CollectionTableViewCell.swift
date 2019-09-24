//
//  CollectionTableViewCell.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 15/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell, ViewCode {
    
    let iconNames = [(sf: "text.justifyleft", normal: "notes"), (sf: "pencil.and.outline", normal: "pencil"), (sf: "mic", normal: "mic"), (sf: "video", normal: "videoCamera"), (sf: "camera", normal: "camera")]
    
    
    // MARK: Properties
    let  collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 16, right: 8)
        layout.itemSize = CGSize(width: 400, height: 100)
        layout.minimumInteritemSpacing = CGFloat(16.0)
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isPagingEnabled = true
        collection.backgroundColor = UIColor(named: "BlueBackground")
        collection.register(CounterGoalsCard.self, forCellWithReuseIdentifier: "collectionCell")
        collection.register(MediaCards.self, forCellWithReuseIdentifier: "mediaCell")
        return collection
    }()
    
    
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        collectionView.delegate = self
        collectionView.dataSource = self
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
        collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
        collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        
    }
}

extension CollectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CounterGoalsCard else { return UICollectionViewCell()}
            
            return cell

        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaCell", for: indexPath) as? MediaCards else { return UICollectionViewCell()}
            
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let animateCell = cell as? CounterGoalsCard
                
                animateCell?.incrementLabel(to: 100, labelNumber: animateCell!.number)
                animateCell?.createCircularPath(colorCircular: "SelectionColor")
                animateCell?.winRain(bubble: UIImage(named: "bubble")!, birdRate: 10, stop: true, scale: 0.3)
                
            }
            
        default:
            guard let cell = cell as? MediaCards else { return }
            if #available(iOS 13.0, *) {
                cell.setupCell(imageName: iconNames[indexPath.row - 1].sf)
            }
            else {
                cell.setupCell(imageName: iconNames[indexPath.row - 1].normal)
            
            
            }
        }
    }
    
    
}

extension CollectionTableViewCell: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UIScreen.main.bounds.width == 1024 {
            return CGSize(width: 496 , height: 300)
        }
        else {
        return CGSize(width: UIScreen.main.bounds.width - 16 , height: 300)
        }}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
}
