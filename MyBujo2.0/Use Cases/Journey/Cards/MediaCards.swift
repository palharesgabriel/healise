//
//  MediaCards.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 22/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class MediaCards: IncrementCollectionViewCell, ViewCode {
    
    // MARK: Properties
    let number = TitleLabel(title: "0")
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: Funcions
    func buildViewHierarchy() {
        self.rainView.addSubviews([number,iconImageView])
    }
    
    func setupConstraints() {
        number.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            number.centerXAnchor.constraint(equalTo: rainView.centerXAnchor,constant: 100),
            number.centerYAnchor.constraint(equalTo: rainView.centerYAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: rainView.centerXAnchor,constant:  -100),
            iconImageView.centerYAnchor.constraint(equalTo: rainView.centerYAnchor)
            ])
    }
    
    func setupAdditionalConfigurantion() {
        
    }
    
    func setupCell(imageName: String, numberToIncrement: Int) {
        if #available(iOS 13.0, *) {
            let configuration = UIImage.SymbolConfiguration(pointSize: 80, weight: .light)
            iconImageView.image = UIImage(systemName: imageName, withConfiguration: configuration)?.withRenderingMode(.alwaysTemplate) ?? UIImage(named: imageName)!.withRenderingMode(.alwaysTemplate)
            
        } else {
            iconImageView.image =  UIImage(named: imageName)!.withRenderingMode(.alwaysTemplate)
        }
        iconImageView.tintColor = UIColor(named: "SelectionColor")
        
        DispatchQueue.main.async {
            self.winRain(bubble: UIImage(named: "bubble")!, birdRate: 4, stop: true, scale: 0.03)
            self.incrementLabel(to: numberToIncrement, labelNumber: self.number)
        }
        
    }
    
}
