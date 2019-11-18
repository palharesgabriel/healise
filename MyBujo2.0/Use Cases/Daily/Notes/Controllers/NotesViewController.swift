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
	let notesView = NotesView()
	
	
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        if let text =  CalendarManager.shared.selectedDay.media?.note {
			notesView.noteTextView.text = text
        }
		setupView()
		configureNavigationBar()
    }
	
	func configureNavigationBar() {
		self.title = "Notes"
		let eraseBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(shouldCleanTextView))
		navigationItem.setRightBarButton(eraseBarButtonItem, animated: true)
	}

	func buildViewHierarchy() {
		view.addSubview(notesView)
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			notesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			notesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			notesView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			notesView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	func setupAdditionalConfigurantion() {
	}
	
	@objc func shouldCleanTextView() {
		notesView.noteTextView.text = String()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		if let text = notesView.noteTextView.text {
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
