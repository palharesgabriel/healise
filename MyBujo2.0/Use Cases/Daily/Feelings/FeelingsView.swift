//
//  FeelingsView.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 02/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import UIKit

class FeelingsView: UIView, ViewCode {
    
    let feelings = [Feeling.angry, Feeling.anxious, Feeling.grateful, Feeling.happy, Feeling.indiferent, Feeling.sad, Feeling.surprised, Feeling.tired]
    // MARK: Properties
    
	var selectedFeeling: Feeling?
	
    let feelingsCardTitle = UILabel(text: "Como você está se sentindo hoje?", font: .title, textColor: .titleColor)
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 8
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.register(FeelingCollectionViewCell.self, forCellWithReuseIdentifier: FeelingCollectionViewCell.reuseIdentifier)
        collection.backgroundColor = .cardsColor
        collection.delegate = self
        collection.dataSource = self
        collection.isScrollEnabled = false
        return collection
    }()
    
    let doneButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Done", for: .normal)
        btn.titleLabel!.font = .medium
        btn.setTitleColor(.actionColor, for: .normal)
        return btn
    }()
    let feelingsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubviews([feelingsCardTitle, doneButton, collectionView])
    }
    
    
    // MARK: Functions
    func setupConstraints() {
        NSLayoutConstraint.activate([
            feelingsCardTitle.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            feelingsCardTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            feelingsCardTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            collectionView.topAnchor.constraint(equalTo: feelingsCardTitle.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -36),
            
            doneButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            doneButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        //
    }
}

extension FeelingsView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeelingCollectionViewCell.reuseIdentifier, for: indexPath) as? FeelingCollectionViewCell else { return UICollectionViewCell()}
        cell.setupCell(feeling: feelings[indexPath.row])
		return cell
    }
	
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		selectedFeeling = feelings[indexPath.row]
	}
	
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width)/4.5, height: (collectionView.frame.size.height)/2)
    }
    
}
