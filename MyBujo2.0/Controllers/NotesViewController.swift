//
//  NotesViewController.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 27/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {

        let controller = NotesView()
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            navigationController?.navigationBar.isHidden = true
            self.view = self.controller
            self.controller.delegate = self
        }
    
}

extension NotesViewController: DismissControllerDelegate {
    func closeViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}
