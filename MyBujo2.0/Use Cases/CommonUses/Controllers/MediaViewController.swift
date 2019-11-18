//
//  MediaViewController.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 10/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class MediaViewController: UIViewController {
    
    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "BlueBackground")
        return view
    }()
    
    func setupInitialView() {
        view.addSubviews([contentView])
    
        NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		view.backgroundColor = UIColor(named: "BlueBackground")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        // Do any additional setup after loading the view.
    }
    
    @objc func exitButtonClicked(sender: ExitButton) {
        dismiss(animated: true, completion: nil)
    }

}
