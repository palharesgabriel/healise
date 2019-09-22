//
//  CollectionTableViewCell.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 15/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell, ViewCode {
    
    
    // MARK: Properties
    let  collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: 400, height: 100)
        layout.minimumInteritemSpacing = CGFloat(16.0)
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
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
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaCell", for: indexPath) as? MediaCards else { return UICollectionViewCell()}
            
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaCell", for: indexPath) as? MediaCards else { return UICollectionViewCell()}
            
            return cell
            
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaCell", for: indexPath) as? MediaCards else { return UICollectionViewCell()}
            
            return cell
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaCell", for: indexPath) as? MediaCards else { return UICollectionViewCell()}
            
            return cell
        case 5:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaCell", for: indexPath) as? MediaCards else { return UICollectionViewCell()}
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let animateCell = cell as? CounterGoalsCard
                
                animateCell?.incrementLabel(to: 100, labelNumber: animateCell!.number)
                animateCell?.createCircularPath(colorCircular: "SelectionColor")
                animateCell?.winRain(bubble:"bubble",birdRate: 8,stop: true)
                
            }
            
        case 1:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let animateCell = cell as? MediaCards
                animateCell?.setupCell(imageName: "camera")
                animateCell?.incrementLabel(to: 23, labelNumber: animateCell!.number)
                animateCell?.winRain(bubble:"camerabubble",birdRate: 1,stop: true)
                
            }
        case 2:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let animateCell = cell as? MediaCards
                animateCell?.setupCell(imageName: "pencil")
                animateCell?.incrementLabel(to: 5, labelNumber: animateCell!.number)
                animateCell?.winRain(bubble:"pencilBubble",birdRate:2 ,stop: true)
                
            }
        case 3:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let animateCell = cell as? MediaCards
                animateCell?.setupCell(imageName: "mic")
                animateCell?.incrementLabel(to: 16, labelNumber: animateCell!.number)
                animateCell?.winRain(bubble:"micBubble",birdRate:2 ,stop: true)
                
            }
            
        case 4:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let animateCell = cell as? MediaCards
                animateCell?.setupCell(imageName: "notes")
                animateCell?.incrementLabel(to: 11, labelNumber: animateCell!.number)
                animateCell?.winRain(bubble:"notesBubble",birdRate:1 ,stop: true)
                
            }
        case 5:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let animateCell = cell as? MediaCards
                animateCell?.setupCell(imageName: "video")
                animateCell?.incrementLabel(to: 24, labelNumber: animateCell!.number)
                animateCell?.winRain(bubble:"videoBubble",birdRate:2 ,stop: true)
                
            }
        default:
            print("Error on collectionviewCadsJourney")
        }
        
    }
    
    
}

extension CollectionTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 450, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
}
