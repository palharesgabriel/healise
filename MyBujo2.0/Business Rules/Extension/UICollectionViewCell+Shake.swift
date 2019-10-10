//
//  UICollectionViewCell+Shake.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 08/10/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import UIKit
// MARK: CollectionViewCell Animation

extension CaptureCollectionViewCell {
	func shake() {
		
		deleteCellButton.isHidden = false
		editable = true
		
	
		let	shakeAnimation = CABasicAnimation(keyPath: "transform.rotation")
//		Duration of animation
		shakeAnimation.duration = 0.1
//		Times the animation will perform
		shakeAnimation.repeatCount = 2
//		When animation over, will plays backwards.
		shakeAnimation.autoreverses = true
//		Initial angle of animation
		let startAngle: Float = (-2) * Float.pi/180
//		Final angle of animation
		let stopAngle = -startAngle
//		Initial position of animation
		shakeAnimation.fromValue = NSNumber(value: startAngle)
//		Final position of animation
		shakeAnimation.toValue = NSNumber(value: stopAngle)

		shakeAnimation.autoreverses = true
		shakeAnimation.duration = 0.5
		shakeAnimation.repeatCount = 10000
		shakeAnimation.timeOffset = Double.random(in: 0...290)
	
		self.backgroundColor = .clear
		captureImageView.layer.add(shakeAnimation, forKey: "shaking")
	}
	
	
	func stopShake() {
		deleteCellButton.isHidden = true
		editable = false
		captureImageView.layer.removeAnimation(forKey: "shaking")
	}
}
