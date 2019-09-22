//
//  CounterGoalsCard.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 20/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class CounterGoalsCard: ReusableCollectionViewCell, ViewCode {
    
    
    // MARK: Properties
     let number = TitleLabel(title: "0")
     let circleLayer = CAShapeLayer()
     let progressLayer = CAShapeLayer()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        number.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    // MARK: Functions
    func incrementLabel(to endValue: Int) {
        number.text = "0"
        let duration: Double = 2.0
        
        DispatchQueue.global().async {
            for iiii in 0 ..< (endValue + 1) {
                let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.sync {
                    self.number.text =  String(iiii)
                }
            }
        }
    }
    
    func buildViewHierarchy() {
        addSubviews([number])
        self.layer.addSublayer(circleLayer)
        self.layer.addSublayer(progressLayer)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            number.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            number.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor)
            ])
    }
    
    func setupAdditionalConfigurantion() {

    }
    
    func createCircularPath() {
        let center: CGPoint = CGPoint(x: self.bounds.size.width*0.5,y: self.bounds.size.height*0.5)
        let circularPath = UIBezierPath(arcCenter: center, radius: 50, startAngle: -.pi / 2, endAngle: 2 * .pi, clockwise: true)
        

        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 20.0  //for thicker circle compared to progressLayer
        
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor(named: "ActionColor")?.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 10.0
        progressLayer.strokeEnd = 0

        
        let progressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        progressAnimation.toValue = 1
        progressAnimation.duration = 3
        progressAnimation.fillMode = .forwards
        progressAnimation.isRemovedOnCompletion = false
        progressLayer.add(progressAnimation, forKey: "progressAnim")
        
    }
}
