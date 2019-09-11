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
        canvasView.backgroundColor = .white
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
        canvasWidth = contentView.frame.width
        
        if let drawing = CalendarManager.shared.currentDate.media?.drawing{
            try? canvasView.drawing = PKDrawing(data: drawing)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // sempre que as subviews atualizarem seu layout (Nesse caso mais usado quando a tela muda de orientação) devemos ajustar o layout do Canvas
        layoutCanvas()
        
    }
    override func exitButtonClicked(sender: ExitButton) {
        
        dismiss(animated: true, completion: {
            let day = CalendarManager.shared.currentDate
            guard let media = day.media else {
                let media = Media(context: CoreDataManager.context)
                media.drawing = self.canvasView.drawing.dataRepresentation()
                media.save()
                return
            }
            media.drawing = self.canvasView.drawing.dataRepresentation()
            media.save()
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
        
        canvasView.contentSize = CGSize(width: canvasWidth * canvasView.zoomScale, height: canvasView.frame.height)
    }
}


