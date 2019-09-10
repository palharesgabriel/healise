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
    var effect: UIVisualEffect? {get set}
    var visualEffect: UIVisualEffectView? {get set}
    func addBlur() -> UIVisualEffectView
}

extension Blurable {
    func addBlur () -> UIVisualEffectView {
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        let blurEffect = UIBlurEffect(style: .light)
        let viewBlurEffect = UIVisualEffectView(effect: blurEffect)
        viewBlurEffect.frame = view.bounds
        viewBlurEffect.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.view.addSubview(viewBlurEffect)
        return viewBlurEffect
    }
    
    func animateIn(view: UIView, visualEffect: UIVisualEffectView, effect: UIVisualEffect) {
        view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        view.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
            visualEffect.effect = effect
            view.alpha = 1
            view.transform = CGAffineTransform.identity
        })
    }
    
    func animateOut(view: UIView, visualEffect: UIVisualEffectView) {
        UIView.animate(withDuration: 0.3, animations: {
            view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            view.alpha = 0
            visualEffect.effect = nil
        }) { (sucess: Bool) in
            view.removeFromSuperview()
            self.dismiss(animated: false, completion: nil)
        }
    }
}
