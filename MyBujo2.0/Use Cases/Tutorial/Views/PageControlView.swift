//
//  PageControlView.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 16/10/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class PageControlView: UIView {
    
    // MARK: View Properties
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .purple
        pageControl.pageIndicatorTintColor = .gray
        pageControl.numberOfPages = 8
        
        return pageControl
    }()
    
    let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        return button
    }()
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
           super.init(frame: .zero)
       }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
    convenience init() {
        self.init(frame: .zero)
        setupView()
    }
    
}

// MARK: View Configuration

extension PageControlView: ViewCode {
    
    func buildViewHierarchy() {
        addSubviews([pageControl, skipButton, nextButton])
    }
    
    func setupConstraints() {
        setupPageControlConstraints()
        setupSkipButtonConstraints()
        setupNextButtonConstraints()
    }
    
    func setupAdditionalConfigurantion() {
        //
    }
    
}

// MARK: Constraints

extension PageControlView {
    
    func setupPageControlConstraints() {
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            pageControl.widthAnchor.constraint(equalToConstant: 20),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func setupSkipButtonConstraints() {
        NSLayoutConstraint.activate([
            skipButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            skipButton.widthAnchor.constraint(equalToConstant: 20),
            skipButton.heightAnchor.constraint(equalToConstant: 20),
            skipButton.trailingAnchor.constraint(equalTo: pageControl.leadingAnchor, constant: -24)
        ])
    }
    
    func setupNextButtonConstraints() {
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            nextButton.widthAnchor.constraint(equalToConstant: 20),
            nextButton.heightAnchor.constraint(equalToConstant: 20),
            nextButton.leadingAnchor.constraint(equalTo: pageControl.trailingAnchor, constant: 24)
        ])
    }
    
}

