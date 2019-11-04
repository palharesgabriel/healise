//
//  RecordButtonView.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 29/10/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class RecordButtonView: UIView {
    
    // MARK: Properties
    weak var recordButtonDelegate: AudioRecordDelegate?
    
    // MARK: View Closures
    let recordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "CardsColor")
        let configuration = UIImage.SymbolConfiguration(pointSize: 40, weight: .light)
        button.setImage(UIImage(systemName: "mic.fill", withConfiguration: configuration)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.setImage(UIImage(systemName: "stop.fill", withConfiguration: configuration)?.withRenderingMode(.alwaysTemplate), for: .selected)
        button.tintColor = UIColor(named: "ActionColor")
        button.setShadow()
        button.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: View methods
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func recordButtonTapped() {
        recordButtonDelegate?.didTapRecordButton()
    }
    
    func setButtonSelection(_ isSelected: Bool) {
        recordButton.isSelected = isSelected
    }
    
    func setButtonInteractivity(_ isEnable: Bool) {
        recordButton.isUserInteractionEnabled = isEnable
    }
    
}

// MARK: View Configuration
extension RecordButtonView: ViewCode {
    
    func buildViewHierarchy() {
        self.addSubview(recordButton)
    }
    
    func setupConstraints() {
        setupRecordButtonConstraints()
    }
    
    func setupAdditionalConfigurantion() {
        //
    }

}

// MARK: Constraints
extension RecordButtonView {
    
    func setupRecordButtonConstraints() {
        NSLayoutConstraint.activate([
            recordButton.topAnchor.constraint(equalTo: self.topAnchor),
            recordButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            recordButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            recordButton.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
}
