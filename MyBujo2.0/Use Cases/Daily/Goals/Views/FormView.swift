//
//  FormView.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 30/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//
import Foundation
import UIKit

protocol FormViewDelegate: class {
    func didPressDone(descript: String?)
}

class FormView: UIView, Shadow, ViewCode {
    
    
    // MARK: Properties
    weak var delegate: FormViewDelegate?
    lazy var instructionLabel = UILabel(text: "Insira uma nova meta", font: .title, textColor: .titleColor)
    
    lazy var goalTextField: UITextView = {
        let txtField = UITextView(frame: .zero)
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.backgroundColor = .white
        txtField.isEditable = true
        txtField.font = .normal
        txtField.textColor = .titleColor
        txtField.layer.borderWidth = 0.1
        txtField.layer.borderColor = UIColor.gray.cgColor
        txtField.layer.cornerRadius = 16
        txtField.clipsToBounds = true
        txtField.backgroundColor = .cardsColor
        txtField.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return txtField
    }()
    lazy var doneButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Done", for: .normal)
        btn.setTitleColor(.actionColor, for: .normal)
        return btn
    }()
    
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addShadow(view: self)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Functions
    func buildViewHierarchy() {
        addSubview(instructionLabel)
        addSubview(goalTextField)
        addSubview(doneButton)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            instructionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            instructionLabel.heightAnchor.constraint(equalToConstant: 40),
            instructionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            goalTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            goalTextField.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 16),
            goalTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            goalTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            
            doneButton.topAnchor.constraint(equalTo: goalTextField.bottomAnchor, constant: 24),
            doneButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        doneButton.setContentHuggingPriority(.defaultHigh, for: .vertical)
        doneButton.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    func setupAdditionalConfigurantion() {
        DispatchQueue.main.async {
            self.backgroundColor = .cardsColor
        }
        doneButton.addTarget(self, action: #selector(tapDoneButton), for: .touchDown)
    }
    
    
    // MARK: Actions Button
    @objc func tapDoneButton() {
        delegate?.didPressDone(descript: goalTextField.text)
    }
}
