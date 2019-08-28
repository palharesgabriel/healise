//
//  Blurable.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 28/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//
import Foundation
import UIKit

protocol Blurable: UIViewController {
    var bluredView: UIView? { get set }
    func addBlur() -> UIView
}

extension Blurable {
    func addBlur () -> UIView {
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        let blurEffect = UIBlurEffect(style: .light)
        let viewBlurEffect = UIVisualEffectView(effect: blurEffect)
        viewBlurEffect.frame = view.bounds
        viewBlurEffect.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.view.addSubview(viewBlurEffect)
        return viewBlurEffect.contentView
    }
}
