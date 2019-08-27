//
//  NotesBujo.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 27/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class NotesBujo: UIView {
    let scrollNotes: UIScrollView = {
        let scrollRegister = UIScrollView()
        scrollRegister.translatesAutoresizingMaskIntoConstraints = false
        return scrollRegister
    }()
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
        scrollFuncionalities()
        addConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func buildViewHierachy() {
        addSubviews([scrollNotes, contentView, noteButton, noteTextFiel, labelNote])
    }
    func addConstraints() {
        addConstraintsScrollRegister()
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
            noteButton.heightAnchor.constraint(equalToConstant: 50),
            noteButton.widthAnchor.constraint(equalToConstant: 50)
            ])
        
    }
    func textFieldContraints() {
        NSLayoutConstraint.activate([
            noteTextFiel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 50),
            noteTextFiel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            noteTextFiel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            noteTextFiel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height)
            
            ])
    }
    func scrollFuncionalities() {
        scrollNotes.contentSize = CGSize(width: UIScreen.main.bounds.width,
                                         height: UIScreen.main.bounds.height)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    func addConstraintsScrollRegister() {
        NSLayoutConstraint.activate([
            scrollNotes.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollNotes.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollNotes.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollNotes.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
            ])
    }
    func addContraintsContencView() {
        let contraintHeightContentView = contentView.heightAnchor.constraint(
            equalTo: scrollNotes.heightAnchor)
        contraintHeightContentView.priority = UILayoutPriority.defaultLow
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollNotes.topAnchor,constant: 8),
            contentView.leadingAnchor.constraint(equalTo: scrollNotes.leadingAnchor,constant: 8),
            contentView.trailingAnchor.constraint(equalTo: scrollNotes.trailingAnchor,constant: -8),
            contentView.bottomAnchor.constraint(equalTo: scrollNotes.bottomAnchor,constant: -8),
            contentView.widthAnchor.constraint(equalTo: scrollNotes.widthAnchor, constant: -16),
            contraintHeightContentView
            ])
    }
    @objc func btnExit() {
        print("exit")
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        let keyboard = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey]
        guard let keyboardFrameValue = keyboard  as? NSValue else {
            return
        }
        let keyboardFrame = self.convert(keyboardFrameValue.cgRectValue, from: nil)
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
        scrollNotes.contentInset = contentInsets
        scrollNotes.scrollIndicatorInsets = contentInsets
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollNotes.contentOffset = .zero
    }
}


extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { (view) in
            self.addSubview(view)
        }
    }
}
