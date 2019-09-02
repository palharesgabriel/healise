//
//  FormView.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 30/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//
import Foundation
import UIKit

protocol FormViewDelegate {
    func didPressDone(descript: String?)
}

class FormView: UIView, Shadow, ViewCode {
    
    var delegate: FormViewDelegate?
    
    lazy var instructionLabel = UILabel(text: "Insert a new goal for today", font: "AvenirNext-Medium", fontSize: 24, textColor: UIColor(named: "TitleColor")!)
    
    
    lazy var goalTextField: UITextView = {
        let txtField = UITextView(frame: .zero)
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.backgroundColor = .white
        txtField.isEditable = true
        txtField.font = UIFont(name: "AvenirNext-Medium", size: 16)
        txtField.textColor = UIColor(named: "TitleColor")
        txtField.layer.borderWidth = 0.1
        txtField.layer.borderColor = UIColor(named: "AvenirNext-Medium")?.cgColor
        txtField.layer.cornerRadius = 16
        txtField.clipsToBounds = true
        txtField.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return txtField
    }()
    
    
    lazy var doneButton :
        UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Done", for: .normal)
        btn.titleLabel!.font = UIFont(name: "AvenirNext-Medium", size: 24)
        btn.setTitleColor(UIColor(named: "TitleColor"), for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addShadow()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(instructionLabel)
        addSubview(goalTextField)
        addSubview(doneButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            instructionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            instructionLabel.heightAnchor.constraint(equalToConstant: 40),
            instructionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            ])
        
        NSLayoutConstraint.activate([
            goalTextField.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 16),
            goalTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            goalTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            goalTextField.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -16)
            ])
        
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: goalTextField.bottomAnchor, constant: 16),
            doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            doneButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            ])
        
        doneButton.setContentHuggingPriority(.defaultHigh, for: .vertical)
        doneButton.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    
    func setupAdditionalConfigurantion() {
        backgroundColor = UIColor(named: "ModalBackground")
        doneButton.addTarget(self, action: #selector(tapDoneButton), for: .touchDown)
    }
    
    @objc func tapDoneButton() {
        delegate?.didPressDone(descript: goalTextField.text)
    }
}
