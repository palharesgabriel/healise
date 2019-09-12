//
//  CanvasLayoutExtension.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 10/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import UIKit
import PencilKit


@available(iOS 13.0, *)
extension DrawingViewController {
    
    func layoutCanvas() {
        let canvasScale = canvasView.bounds.width / canvasWidth
        canvasView.maximumZoomScale = 5.0
        canvasView.minimumZoomScale *= canvasScale
        if !isZoomed {
            canvasView.zoomScale = canvasView.minimumZoomScale
            
            canvasWidth = canvasView.bounds.width
            
            // Scrolla para o topo.
            canvasView.contentOffset = CGPoint(x: 0, y: -canvasView.adjustedContentInset.top)
        }
    }
    
    // MARK: Breve inicialização da ToolPicker
    func setupToolPicker() {
        if let toolPicker = PKToolPicker.shared(for: UIApplication.shared.keyWindow!) {
            toolPicker.setVisible(true, forFirstResponder: canvasView)
            toolPicker.addObserver(canvasView)
            toolPicker.addObserver(self)
            
            updateLayout(for: toolPicker)
            canvasView.becomeFirstResponder()
        }
    }
    
    func updateLayout(for toolPicker: PKToolPicker) {
        let obscuredFrame = toolPicker.frameObscured(in: contentView)
        
        // If the tool picker is floating over the canvas, it also contains
        // undo and redo buttons.
        if obscuredFrame.isNull {
            canvasView.contentInset = .zero
        }
            
            // Otherwise, the bottom of the canvas should be inset to the top of the
            // tool picker, and the tool picker no longer displays its own undo and
            // redo buttons.
        else {
            canvasView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.bounds.maxY - obscuredFrame.minY, right: 0)
        }
        canvasView.scrollIndicatorInsets = canvasView.contentInset
    }
}

@available(iOS 13.0, *)
extension DrawingViewController: PKCanvasViewDelegate{
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        // sempre que o desenho mudar (consequentemente aumentar) devemos atualizar o tamanho do content do canvas
    }
    
}

@available(iOS 13.0, *)
extension DrawingViewController: PKToolPickerObserver{
    func toolPickerFramesObscuredDidChange(_ toolPicker: PKToolPicker) {
        updateLayout(for: toolPicker)
    }
    
    // Delegate method: Note that the tool picker has become visible or hidden.
    func toolPickerVisibilityDidChange(_ toolPicker: PKToolPicker) {
        updateLayout(for: toolPicker)
    }
}
