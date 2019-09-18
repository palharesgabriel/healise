//
//  NotesViewController.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 27/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class NotesViewController: MediaViewController {
    
    
    // MARK: Properties
    let notesView = NotesView()
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        constraintNotesView()
        
        if let text =  CalendarManager.shared.selectedDay.media?.note {
            notesView.noteTextField.text = text
        }
    }
    
    func constraintNotesView() {
        contentView.addSubview(notesView)
        NSLayoutConstraint.activate([
            notesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            notesView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            notesView.topAnchor.constraint(equalTo: contentView.topAnchor),
            notesView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
    
    override func exitButtonClicked(sender: ExitButton) {
        if let text = notesView.noteTextField.text {
            if let media = CalendarManager.shared.selectedDay.media {
                media.note = text
            } else {
                let media = Media(context: CoreDataManager.context)
                media.note = text
                CalendarManager.shared.selectedDay.media = media
                CalendarManager.shared.selectedDay.save()
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
