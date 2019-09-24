//
//  CounterGoalsCard.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 20/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class CounterGoalsCard: IncrementCollectionViewCell, ViewCode {
    
    
    // MARK: Properties
     let number = TitleLabel(title: "0")
     let goalLabel = TitleLabel(title: "Your goals this month")
     let circleLayer = CAShapeLayer()
     let progressLayer = CAShapeLayer()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: Functions
    func buildViewHierarchy() {
        self.rainView.addSubviews([number,goalLabel])
        self.rainView.layer.addSublayer(circleLayer)
        self.rainView.layer.addSublayer(progressLayer)
    }
    
    
    
    func setupConstraints() {
        number.translatesAutoresizingMaskIntoConstraints = false
        goalLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            number.centerXAnchor.constraint(equalTo: rainView.centerXAnchor),
            number.centerYAnchor.constraint(equalTo: rainView.centerYAnchor),
            goalLabel.centerXAnchor.constraint(equalTo: rainView.centerXAnchor),
            goalLabel.centerYAnchor.constraint(equalTo: rainView.centerYAnchor,constant: 100)
            ])
    }
    
    func setupAdditionalConfigurantion() {
       
    }
    
    func createCircularPath(colorCircular: String) {
        let center: CGPoint = CGPoint(x: self.rainView.bounds.size.width*0.5,y: self.rainView.bounds.size.height*0.5)
        let circularPath = UIBezierPath(arcCenter: center, radius: 50, startAngle: -.pi / 2, endAngle: 2 * .pi, clockwise: true)
        

        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 20.0
        
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor(named: colorCircular)?.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 2.0
        progressLayer.strokeEnd = 0
  
        let progressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        progressAnimation.toValue = 1
        progressAnimation.duration = 3
        progressAnimation.fillMode = .forwards
        progressAnimation.isRemovedOnCompletion = false
        progressLayer.add(progressAnimation, forKey: "progressAnim")
        
    }
}
