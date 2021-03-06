//
//  CustomNavigationController.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 13/11/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        navigationBar.tintColor = .actionColor
        navigationBar.backgroundColor = .blueBackground
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.prefersLargeTitles = true
//        navigationBar.shadowImage = UIImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
