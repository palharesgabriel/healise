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
        canvasView.backgroundColor = .blueBackground
        return canvasView
    }()
    
    var canvasWidth: CGFloat = 0
    var canvasOverscrollHeight: CGFloat = 500 // número que define quanto a mais da altura da tela você quer que o canvas tenha de altura
    var isZoomed = false
    weak var delegateTarget: MediaCollectionViewTargetDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        constraintCanvasView()
        setupToolPicker()
		setupNavigationBar()
		self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        localizableLabel()
    }
    func localizableLabel() {
        let formatStringGoalLabel = NSLocalizedString("Drawing",
                                             comment: "Drawing")
        self.title = String.localizedStringWithFormat(formatStringGoalLabel)
    }
	
	override func viewDidDisappear(_ animated: Bool) {
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasWidth = contentView.frame.width
        
        if let drawing = CalendarManager.shared.selectedDay.media?.drawing {
            try? canvasView.drawing = PKDrawing(data: drawing)
        }

    }

	func setupNavigationBar() {
		let shareButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareDraw))
		navigationItem.setRightBarButton(shareButtonItem, animated: true)
	}
	
	@objc func shareDraw() {
		let image = canvasView.drawing.image(from: canvasView.frame, scale: 1)
		let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
		present(activityController, animated: true, completion: nil)
	}
	
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // sempre que as subviews atualizarem seu layout (Nesse caso mais usado quando a tela muda de orientação) devemos ajustar o layout do Canvas
        layoutCanvas()
        
    }
        
	override func viewWillDisappear(_ animated: Bool) {
		saveDraw()
		self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
	}

	
	func saveDraw() {
		let day = CalendarManager.shared.selectedDay
		guard let media = day.media else {
			let media = Media(context: CoreDataManager.context)
			media.drawing = self.canvasView.drawing.dataRepresentation()
			day.media = media
			day.save()
			return
		}
		media.drawing = self.canvasView.drawing.dataRepresentation()
		day.save()
        delegateTarget?.mediaTarget()
	}
        
    func constraintCanvasView() {
        canvasView.delegate = self
        canvasView.alwaysBounceVertical = true
        canvasView.allowsFingerDrawing = true
        contentView.addSubview(canvasView)
        
        NSLayoutConstraint.activate([
            canvasView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			canvasView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            canvasView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        
        canvasView.contentSize = CGSize(width: canvasWidth * canvasView.zoomScale, height: canvasView.frame.height)
    }
}
