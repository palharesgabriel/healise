//
//  NotesBujo.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 27/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class NotesView: UIView, ViewCode {
    
    // MARK: Properties
    let noteTextField: UITextView = {
        let textField = UITextView()
        textField.text = ""
        textField.backgroundColor = .clear
        textField.font = UIFont(name: "AvenirNext-Medium", size: 16)
        textField.textColor = .black
        textField.returnKeyType = UIReturnKeyType.done
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 16
        textField.layer.borderWidth = 0.1
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor(named: "TitleColor")?.cgColor
        textField.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return textField
    }()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Functions
    func buildViewHierarchy() {
        addSubviews([noteTextField])
    }
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            noteTextField.topAnchor.constraint(equalTo: topAnchor,constant: 8),
            noteTextField.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            noteTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            noteTextField.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -16)
            
            ])
    }
    func setupAdditionalConfigurantion() {
    }
    // MARK: Actions Buttons
}
