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
    var effect: UIVisualEffect? {get set}
    var visualEffect: UIVisualEffectView? {get set}
    func addBlur() -> UIVisualEffectView
}

extension Blurable {
    func addBlur () -> UIVisualEffectView {
        self.view.backgroundColor = UIColor(named: "BlueBackground")?.withAlphaComponent(0.2)
        let blurEffect = UIBlurEffect(style: .dark)
        let viewBlurEffect = UIVisualEffectView(effect: blurEffect)
        viewBlurEffect.frame = view.bounds
        viewBlurEffect.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.view.addSubview(viewBlurEffect)
        return viewBlurEffect
    }
}
