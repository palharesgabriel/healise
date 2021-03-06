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
    let iconNames = [(sf: "text.justifyleft", normal: "notes"), (sf: "pencil.and.outline", normal: "pencil"), (sf: "mic", normal: "mic"), (sf: "camera", normal: "camera")]
    
    var monthData: MonthData {
            if let month = CoreDataManager.getMonthData(month: CalendarManager.shared.currentMonthComponent) {
                return month
            }
            return MonthData()
    }
    
    let  collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 16, right: 8)
        layout.itemSize = CGSize(width: 400, height: 100)
        layout.minimumInteritemSpacing = CGFloat(16.0)
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isPagingEnabled = true
        collection.backgroundColor = .blueBackground
        return collection
    }()
    
    
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
//        collectionView.delegate = self
//        collectionView.dataSource = self
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        
        default:
            break
        }
        return UICollectionViewCell()
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
            return CGSize(width: UIScreen.main.bounds.width - 16 , height: 300)
        default:
            let portraitSize = CGSize(width: UIScreen.main.bounds.width/2 - 16 , height: 300)
            let width = UIScreen.main.bounds.width * 0.8
            let landscapeSize = CGSize(width: width/2 - 16, height: 300)
            return UIDevice.current.orientation.isLandscape ? landscapeSize : portraitSize
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
}
