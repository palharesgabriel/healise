//
//  NotesBujo.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 27/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class NotesBujo: UIView {
    
    let contentView: UIView  = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    let noteTextFiel: UITextView = {
        let textField = UITextView()
        textField.text = " Create a Note Here "
        textField.textAlignment = .left
        textField.backgroundColor = .clear
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.layer.cornerRadius = 4
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let noteButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("X", for: .normal)
        btn.addTarget(self, action: #selector(btnExit), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        return btn
    }()
    let labelNote: UILabel = {
        let label = UILabel()
        label.text = "Note Day"
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        buildViewHierachy()
        addConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func buildViewHierachy() {
        addSubviews([contentView, noteButton, noteTextFiel, labelNote])
    }
    func addConstraints() {
        addContraintsContencView()
        btnContraints()
        textFieldContraints()
        labelContraints()
    }
    func labelContraints() {
        NSLayoutConstraint.activate([
            labelNote.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            labelNote.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
            ])
        
    }
    func btnContraints() {
        NSLayoutConstraint.activate([
            noteButton.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 4),
            noteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -4),
            noteButton.heightAnchor.constraint(equalToConstant: 48),
            noteButton.widthAnchor.constraint(equalToConstant: 48)
            ])
        
    }
    func textFieldContraints() {
        NSLayoutConstraint.activate([
            noteTextFiel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 48),
            noteTextFiel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            noteTextFiel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            noteTextFiel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -16)
            
            
            ])
    }
    
    
    func addContraintsContencView() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 8),
            contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 8),
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -8),
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -8),
            contentView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: -16)
            ])
    }
    @objc func btnExit() {
        print("exit")
    }
}
extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { (view) in
            self.addSubview(view)
        }
    }
}
