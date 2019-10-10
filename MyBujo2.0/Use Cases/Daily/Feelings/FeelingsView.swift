//
//  FeelingsView.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 02/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import UIKit

class FeelingsView: UIView, Shadow, ViewCode {
    
    let feelings = [Feeling.angry, Feeling.anxious, Feeling.grateful, Feeling.happy, Feeling.indiferent, Feeling.sad, Feeling.surprised, Feeling.tired]
    // MARK: Properties
    
    let feelingsCardTitle = UILabel(text: "How are you feeling today?", font: "AvenirNext-Medium", fontSize: 24, textColor: UIColor(named: "TitleColor")!,localizableString: "How are you feeling today?")
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        flowLayout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.register(FeelingCollectionViewCell.self, forCellWithReuseIdentifier: FeelingCollectionViewCell.reuseIdentifier)
        collection.backgroundColor = UIColor(named: "CardsColor")
        collection.delegate = self
        collection.dataSource = self
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    let doneButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Done", for: .normal)
        btn.titleLabel!.font = UIFont(name: "AvenirNext-Medium", size: 24)
        btn.setTitleColor(UIColor(named: "TitleColor"), for: .normal)
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
        addShadow(view: self)
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
            feelingsCardTitle.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            feelingsCardTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            feelingsCardTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
//            feelingsCardTitle.heightAnchor.constraint(equalToConstant: 32),
            
            collectionView.topAnchor.constraint(equalTo: feelingsCardTitle.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: doneButton.topAnchor),
//            collectionView.heightAnchor.constraint(equalToConstant: 100),
            
            doneButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            doneButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
//            doneButton.heightAnchor.constraint(equalToConstant: 32)
            ])
        
        doneButton.setContentHuggingPriority(.defaultHigh, for: .vertical)
        doneButton.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    
    func setupAdditionalConfigurantion() {
        
    }
}

extension FeelingsView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeelingCollectionViewCell.reuseIdentifier, for: indexPath) as? FeelingCollectionViewCell else { return UICollectionViewCell()}
        cell.setupCell(feeling: feelings[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width - 32)/5, height: collectionView.frame.size.height)
    }
}
