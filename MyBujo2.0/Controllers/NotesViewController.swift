//
//  NotesViewController.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 27/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    
    // MARK: Properties
    let notesView = NotesView()
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        self.view = self.notesView
        self.notesView.delegate = self
        
        if let text =  CalendarManager.shared.selectedDay.media?.note {
            notesView.noteTextField.text = text
        }
    }
}

    // MARK: Extensions
extension NotesViewController: DismissControllerDelegate {
    func closeViewController() {
        
        if let text = notesView.noteTextField.text {
            if let media = CalendarManager.shared.selectedDay.media{
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
