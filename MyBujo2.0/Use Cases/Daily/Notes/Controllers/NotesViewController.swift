//
//  NotesViewController.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 27/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class NotesViewController: MediaViewController, ViewCode {

    // MARK: Properties
    
    // MARK: Properties
    weak var delegateTarget: MediaCollectionViewTargetDelegate?
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
    
    // MARK: Functions
    func buildViewHierarchy() {
		view.addSubviews([noteTextView])
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
			noteTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 8),
			noteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
			noteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			noteTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -16)
		])
    }
    
	func setupAdditionalConfigurantion() {

	}
	
	
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        if let text =  CalendarManager.shared.selectedDay.media?.note {
			noteTextView.text = text
        }
		setupView()
		configureNavigationBar()
		shouldDoNoteTextViewFirstResponder()
    }
	
	func shouldDoNoteTextViewFirstResponder() {
		self.noteTextView.becomeFirstResponder()
	}
	
	func configureNavigationBar() {
		self.title = "Notes"
		let eraseBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(shouldCleanTextView))
		navigationItem.setRightBarButton(eraseBarButtonItem, animated: true)
	}

	@objc func shouldCleanTextView() {
		noteTextView.text = String()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
        delegateTarget?.mediaTarget()
		if let text = noteTextView.text {
		   if let media = CalendarManager.shared.selectedDay.media {
			   media.note = text
		   } else {
			   let media = Media(context: CoreDataManager.context)
			   media.note = text
			   CalendarManager.shared.selectedDay.media = media
			   CalendarManager.shared.selectedDay.save()
		   }
	   }
        
	}
	   
}
