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
        addSubviews([number,goalLabel])
        self.layer.addSublayer(circleLayer)
        self.layer.addSublayer(progressLayer)
    }
    
    func winRain() {
        let flakeEmitterCell = CAEmitterCell()
        flakeEmitterCell.contents = UIImage(named: "checkRain")?.cgImage
        flakeEmitterCell.scale = 0.4
        flakeEmitterCell.scaleRange = 0.3
        flakeEmitterCell.emissionRange = .pi
        flakeEmitterCell.lifetime = 20.0
        flakeEmitterCell.birthRate = 40
        flakeEmitterCell.velocity = -30
        flakeEmitterCell.velocityRange = -20
        flakeEmitterCell.yAcceleration = 30
        flakeEmitterCell.xAcceleration = 5
        flakeEmitterCell.spin = -0.5
        flakeEmitterCell.spinRange = 1.0
        
        let snowEmitterLayer = CAEmitterLayer()
        snowEmitterLayer.emitterPosition = CGPoint(x: self.bounds.width / 2.0, y: 0)
        snowEmitterLayer.emitterSize = CGSize(width: self.bounds.width, height: 0)
        snowEmitterLayer.emitterShape = CAEmitterLayerEmitterShape.line
        snowEmitterLayer.beginTime = CACurrentMediaTime()
        snowEmitterLayer.timeOffset = 10
        snowEmitterLayer.emitterCells = [flakeEmitterCell]
        self.layer.addSublayer(snowEmitterLayer)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
            snowEmitterLayer.removeFromSuperlayer()
        }
        
    }
    
    func setupConstraints() {
        number.translatesAutoresizingMaskIntoConstraints = false
        goalLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            number.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            number.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            goalLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            goalLabel.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor,constant: 100)
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
        circleLayer.lineWidth = 20.0
        
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor(named: "SelectionColor")?.cgColor
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
