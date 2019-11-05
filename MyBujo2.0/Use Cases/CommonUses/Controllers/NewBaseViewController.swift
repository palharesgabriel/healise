//
//  NewsBaseViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 12/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//
import UIKit

class NewBaseViewController: UIViewController, Blurable {
    var visualEffect: UIVisualEffectView?
    
    var reusableView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visualEffect = addBlur()
        view.addSubview(reusableView)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissWhenTouchedOnBlured))
        tapGesture.delegate = self
    }
    
    @objc func dismissWhenTouchedOnBlured() {
        dismiss(animated: true, completion: nil)
    }
}

extension NewBaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == self.view
    }
}
