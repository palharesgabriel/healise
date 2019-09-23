//
//  ReusableCollectionViewCell.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 15/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class ReusableCollectionViewCell: UICollectionViewCell, Shadow {

    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        addShadow(view: self)
      
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Functions
    func incrementLabel(to endValue: Int, labelNumber: UILabel) {
        labelNumber.text = "0"
        let duration: Double = 2.0
        
        DispatchQueue.global().async {
            for iiii in 0 ..< (endValue + 1) {
                let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.sync {
                    labelNumber.text =  String(iiii)
                }
            }
        }
    }
    func winRain(bubble: String, birdRate: Float,stop: Bool) {
        let flakeEmitterCell = CAEmitterCell()
        flakeEmitterCell.contents = UIImage(named: bubble)?.cgImage
        flakeEmitterCell.scale = 0.03
        flakeEmitterCell.scaleRange = 0.9
        flakeEmitterCell.emissionRange = .pi
        flakeEmitterCell.lifetime = 20.0
        flakeEmitterCell.birthRate = birdRate
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
        if stop == true {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
            snowEmitterLayer.lifetime = 0.0
            }}
        
    }
    

    
}
