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

extension UICollectionViewCell {
	func shake() {
		let	shakeAnimation = CABasicAnimation(keyPath: "transform.rotation")
//		Duration of animation
		shakeAnimation.duration = 0.05
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
		shakeAnimation.toValue = NSNumber(value: 3*stopAngle)

		shakeAnimation.autoreverses = true
		shakeAnimation.duration = 0.15
		shakeAnimation.repeatCount = 10000
		shakeAnimation.timeOffset = Double.random(in: 0...290)
		
		UIView.animate(withDuration: 0.5) {
			self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		}
		
		let layer: CALayer = self.layer
		layer.add(shakeAnimation, forKey: "shaking")
	}
	
	
	func stopShake() {
		let layer: CALayer = self.layer
		layer.removeAnimation(forKey: "shaking")
	}
}
