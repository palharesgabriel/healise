//
//  ReusableCollectionViewCell.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 15/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class ReusableCollectionViewCell: UICollectionViewCell, ViewCode, Shadow {
    
    
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addShadow(view: self)
        backgroundColor = .white
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Functions
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupAdditionalConfigurantion() {
        
    }
}
