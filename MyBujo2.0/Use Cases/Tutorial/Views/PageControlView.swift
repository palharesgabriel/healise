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
        self.backgroundColor = .white
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
    convenience init() {
        self.init(frame: .zero)
        setupView()
    }
    
    func updatePageControl(currentPageIndex: Int) {
        pageControl.currentPage = currentPageIndex
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
            pageControl.centerYAnchor.constraint(equalTo: skipButton.centerYAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pageControl.leadingAnchor.constraint(equalTo: skipButton.trailingAnchor, constant: 32),
            pageControl.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor, constant: -32)
        ])
    }
    
    func setupSkipButtonConstraints() {
        NSLayoutConstraint.activate([
            skipButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),
            skipButton.heightAnchor.constraint(equalToConstant: 35),
            skipButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
    }
    
    func setupNextButtonConstraints() {
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),
            nextButton.heightAnchor.constraint(equalToConstant: 35),
            nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
    
}
