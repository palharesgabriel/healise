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

class DoneButton: UIButton {
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.translatesAutoresizingMaskIntoConstraints = false
		self.setTitle("Done", for: .normal)
        self.titleLabel?.font = .medium
		self.isEnabled = false
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override var isEnabled: Bool {
		didSet {
			self.isEnabled ? self.setTitleColor(UIColor(named: "ActionColor"), for: .normal)
			 : self.setTitleColor(UIColor.systemGray, for: .normal)
		}
	}
}

class FormView: UIView, Shadow, ViewCode {
    
    let maxCharCount = 50
    // MARK: Properties
    weak var delegate: FormViewDelegate?
 
	let instructionLabel = UILabel(text: "Insert a new goal for today", font: .title, textColor: UIColor(named: "TitleColor")!)
		
	lazy var charsCounterLabel = UILabel(text: "0|\(self.maxCharCount)", font: .normal, textColor: .black)
    
	let goalTextView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        textView.isEditable = true
        textView.font = .normal
        textView.textColor = UIColor(named: "TitleColor")
        textView.layer.borderWidth = 0.1
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.cornerRadius = 16
        textView.clipsToBounds = true
        textView.backgroundColor = UIColor(named: "CardsColor")
        textView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return textView
    }()

    lazy var doneButton = DoneButton()

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addShadow(view: self)
		goalTextView.delegate = self
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Functions
    func buildViewHierarchy() {
        addSubview(instructionLabel)
        addSubview(goalTextView)
        addSubview(doneButton)
		addSubview(charsCounterLabel)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            instructionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            instructionLabel.heightAnchor.constraint(equalToConstant: 40),
			instructionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),

			charsCounterLabel.bottomAnchor.constraint(equalTo: goalTextView.bottomAnchor, constant: -8),
			charsCounterLabel.trailingAnchor.constraint(equalTo: goalTextView.trailingAnchor, constant: -8),

            goalTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            goalTextView.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 16),
            goalTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            goalTextView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            
            doneButton.topAnchor.constraint(equalTo: goalTextView.bottomAnchor, constant: 24),
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
		charsCounterLabel.textColor = .systemGreen
    }
    
    
    // MARK: Actions Button
    @objc func tapDoneButton() {
		let text = goalTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        delegate?.didPressDone(descript: text)
    }
	
	func updateChasCounterLabel(count: Int) {
		charsCounterLabel.text = "\(count)|\(self.maxCharCount)"
		switch count {
		case 0...30:
			charsCounterLabel.textColor = .systemGreen
		case 30...40:
			charsCounterLabel.textColor = .systemYellow
		case 40...50:
			charsCounterLabel.textColor = .systemOrange
		default:
			charsCounterLabel.textColor = .systemRed
		}
	}
}

extension FormView: UITextViewDelegate {
	func textViewDidChange(_ textView: UITextView) {
		let text = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
		updateChasCounterLabel(count: text.count)
		let validation = text.isEmpty || text.count > maxCharCount
		doneButton.isEnabled =  validation ? false : true
	}
}
