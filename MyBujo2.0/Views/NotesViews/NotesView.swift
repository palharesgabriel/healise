//
//  NotesBujo.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 27/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class NotesView: UIView, ViewCode {
    var delegate: DismissControllerDelegate?
    
    let noteTextField: UITextView = {
        let textField = UITextView()
        textField.text = "Create a note here 😀"
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
    
    let noteButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("X", for: .normal)
        btn.setTitleColor(UIColor(named: "TitleColor"), for: .normal)
        btn.addTarget(self, action: #selector(btnExit), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let labelNote: UILabel = {
        let label = UILabel()
        label.text = "Note"
        label.font = UIFont(name: "AvenirNext-Medium", size: 24)
        label.textColor = UIColor(named: "TitleColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func buildViewHierarchy() {
        addSubviews([noteButton, noteTextField, labelNote])
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            noteButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 16),
            noteButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -16),
            noteButton.heightAnchor.constraint(equalToConstant: 40),
            noteButton.widthAnchor.constraint(equalToConstant: 40)
            ])
        
        NSLayoutConstraint.activate([
            labelNote.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            labelNote.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            labelNote.trailingAnchor.constraint(equalTo: noteButton.leadingAnchor, constant: -16)
            ])
        
        NSLayoutConstraint.activate([
            noteTextField.topAnchor.constraint(equalTo: labelNote.bottomAnchor,constant: 16),
            noteTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 16),
            noteTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            noteTextField.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -16)
            
            ])
        

        

        
        
        
    }
    
    func setupAdditionalConfigurantion() {
        backgroundColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @objc func btnExit() {
        self.delegate?.closeViewController()
    }
}
