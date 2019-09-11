//
//  MediaViewController.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 10/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class MediaViewController: UIViewController, ViewCode {
    
    var titleLabel: TitleLabel!
    var exitButton = ExitButton()
    
    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func buildViewHierarchy() {
        view.addSubviews([titleLabel, exitButton, contentView])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: exitButton.leadingAnchor, constant:  -16),
            
            exitButton.heightAnchor.constraint(equalToConstant: 40),
            exitButton.widthAnchor.constraint(equalToConstant: 40),
            exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            
            contentView.topAnchor.constraint(equalTo: exitButton.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }
    
    func setupAdditionalConfigurantion() {
        //
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        exitButton.addTarget(self, action: #selector(exitButtonClicked(sender:)), for: .touchUpInside)
        

        // Do any additional setup after loading the view.
    }
    
    @objc func exitButtonClicked(sender: ExitButton){
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
