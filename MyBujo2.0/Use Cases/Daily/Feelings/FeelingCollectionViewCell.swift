//
//  FeelingView.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 02/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class FeelingCollectionViewCell: UICollectionViewCell, ViewCode {
        
	override var isSelected: Bool {
		didSet {
			didSelect()
		}
	}
	
    static let reuseIdentifier = "feelingCell"
    
    // MARK: Propertiesq
    var feeling: Feeling!
    
    let feelingCircle: UIView = {
       let view = UIView()
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    let feelingTitle: UILabel = {
       let lbl = UILabel()
       lbl.translatesAutoresizingMaskIntoConstraints = false
       lbl.textAlignment = .center
       return lbl
    }()
    
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    func setupCell(feeling: Feeling) {
        self.feeling = feeling
        feelingTitle.text = feeling.rawValue
        feelingCircle.backgroundColor = feeling.color
        didSelect()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Functions
    func buildViewHierarchy() {
        contentView.addSubview(feelingCircle)
        contentView.addSubview(feelingTitle)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            feelingCircle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            feelingCircle.widthAnchor.constraint(equalToConstant: 24),
            feelingCircle.heightAnchor.constraint(equalToConstant: 24),
            feelingCircle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
			
				feelingTitle.topAnchor.constraint(equalTo: feelingCircle.bottomAnchor, constant: 8),
				feelingTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
				feelingTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
				feelingTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
			])
		}
		
		func setupAdditionalConfigurantion() {
			feelingCircle.clipsToBounds = true
			feelingCircle.layer.masksToBounds = false
			feelingCircle.layer.cornerRadius = 12
		}
		
		func didSelect() {
			if isSelected {
				feelingCircle.layer.borderColor = UIColor(named: "SelectionColor")?.cgColor
				feelingCircle.self.layer.borderWidth = 3

			} else {
				feelingCircle.layer.borderColor = UIColor.clear.cgColor
				feelingCircle.self.layer.borderWidth = 1
			}
		}
	}
