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
    let noteTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Aproveite esse espaço do seu modo"
        textView.backgroundColor = .clear
        textView.font = UIFont(name: "AvenirNext-Medium", size: 16)
		textView.textColor = .label
		textView.returnKeyType = UIReturnKeyType.default
        textView.clipsToBounds = true
        textView.translatesAutoresizingMaskIntoConstraints = false
		return textView
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
        addSubviews([noteTextView])
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
			noteTextView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 8),
            noteTextView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            noteTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            noteTextView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -16)
		])
    }
    func setupAdditionalConfigurantion() {
		backgroundColor = .systemBackground
    }
}
