//
//  WelcomeViewController.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 16/10/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let pageControllView = PageControlView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = pageControllView
        
    }

}
