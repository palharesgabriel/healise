//
//  NewAudioView.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 27/11/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class NewAudioView: UIView {
    
    weak var delegate: NewAudioDelegate?
    
    let nameYourAudioLabel: UILabel = {
        let label = UILabel(text: "Dê um nome para o seu audio", font: .title, textColor: .titleColor)
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "Meu maravilhoso áudio")
        textField.backgroundColor = .cardsColor
        textField.font = .normal
        textField.layer.borderWidth = 0.1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 8
        textField.clipsToBounds = true
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        return textField
    }()
    
    let doneButton: UIButton = {
        let button = DoneButton()
        button.isEnabled = true
        button.addTarget(self, action: #selector(didTapDoneButton), for: .touchDown)
        return button
    }()
    
    @objc func didTapDoneButton() {
        if let name = nameTextField.text {
            delegate?.didEnterAudioName(name)
        } else {
            delegate?.didEnterAudioName("Sem nome")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blueBackground
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NewAudioView: ViewCode {
    
    func buildViewHierarchy() {
        self.addSubviews([nameYourAudioLabel, nameTextField, doneButton])
    }
    
    func setupConstraints() {
        setupLabelConstraints()
        setupNameTextFieldConstraints()
        setupDoneButtonConstraints()
    }
    
    func setupAdditionalConfigurantion() {
        //
    }
    
}

extension NewAudioView {

    func setupLabelConstraints() {
        NSLayoutConstraint.activate([
            nameYourAudioLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            nameYourAudioLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            nameYourAudioLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            nameYourAudioLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupNameTextFieldConstraints() {
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: nameYourAudioLabel.bottomAnchor, constant: 16),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupDoneButtonConstraints() {
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 24),
            doneButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
}

