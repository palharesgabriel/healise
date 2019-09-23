//
//  MediaCards.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 22/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class MediaCards: ReusableCollectionViewCell, ViewCode {
    
    // MARK: Properties
    let number = TitleLabel(title: "0")
    let iconNames = [(sf: "text.justifyleft", normal: "notes"), (sf: "pencil.and.outline", normal: "pencil"), (sf: "mic", normal: "mic"), (sf: "video", normal: "videoCamera"), (sf: "camera", normal: "camera")]
    
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
        addSubviews([number,iconImageView])
    }
    
    func setupConstraints() {
        number.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            number.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor,constant: 100),
            number.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor,constant:  -100),
            iconImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
            ])
    }
    
    func setupAdditionalConfigurantion() {
        
    }
    func setupCell(imageName: String) {
        if #available(iOS 13.0, *) {
            let configuration = UIImage.SymbolConfiguration(pointSize: 80, weight: .light)
            iconImageView.image = UIImage(systemName: imageName, withConfiguration: configuration)?.withRenderingMode(.alwaysTemplate) ?? UIImage(named: "bubble")!.withRenderingMode(.alwaysTemplate)
        } else {
            iconImageView.image =  UIImage(named: "notes")!.withRenderingMode(.alwaysTemplate)
        }
        iconImageView.tintColor = UIColor(named: "SelectionColor")
    }
    
}
