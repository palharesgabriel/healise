//
//  DrawingViewController.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 10/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit
import PencilKit

@available(iOS 13.0, *)
class DrawingViewController: MediaViewController {
    
    lazy var canvasView: PKCanvasView = {
        let canvasView = PKCanvasView()
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        return canvasView
    }()
    
    var canvasWidth: CGFloat = 0
    var canvasOverscrollHeight: CGFloat = 500 // número que define quanto a mais da altura da tela você quer que o canvas tenha de altura
    var isZoomed = false
    
    override func viewWillAppear(_ animated: Bool) {
        constraintCanvasView()
        setupToolPicker()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        canvasWidth = view.frame.width
        canvasView.backgroundColor = .white

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // sempre que as subviews atualizarem seu layout (Nesse caso mais usado quando a tela muda de orientação) devemos ajustar o layout do Canvas
        layoutCanvas()
        
    }
    override func exitButtonClicked(sender: ExitButton) {
        dismiss(animated: true, completion: {
            //
        })
    }
    
    func constraintCanvasView(){
        canvasView.delegate = self
        canvasView.alwaysBounceVertical = true
        canvasView.allowsFingerDrawing = true
        contentView.addSubview(canvasView)
        
        NSLayoutConstraint.activate([
            canvasView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            canvasView.topAnchor.constraint(equalTo: contentView.topAnchor),
            canvasView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ])
        
        canvasView.contentSize = canvasView.frame.size
    }
}


