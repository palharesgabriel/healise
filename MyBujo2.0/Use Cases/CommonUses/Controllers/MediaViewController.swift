//
//  MediaViewController.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 10/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class MediaViewController: UIViewController {
    
    var titleLabel: TitleLabel!
    var exitButton = ExitButton()
    
    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "BlueBackground")
        return view
    }()
    
    func setupInitialView() {
        view.addSubviews([titleLabel, exitButton, contentView])
    
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: exitButton.leadingAnchor, constant:  -16),
            
            exitButton.heightAnchor.constraint(equalToConstant: 40),
            exitButton.widthAnchor.constraint(equalToConstant: 40),
            exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            exitButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: 0),
            
            contentView.topAnchor.constraint(equalTo: exitButton.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
		view.backgroundColor = UIColor(named: "BlueBackground")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        exitButton.addTarget(self, action: #selector(exitButtonClicked(sender:)), for: .touchUpInside)
		exitButton.titleLabel?.textAlignment = .right
        // Do any additional setup after loading the view.
    }
    
    @objc func exitButtonClicked(sender: ExitButton) {
        dismiss(animated: true, completion: nil)
    }
    
    init(title: String = "default") {
        super.init(nibName: nil, bundle: nil)
        titleLabel = TitleLabel(title: title)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
