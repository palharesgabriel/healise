//
//  CapturesViewController+ImagePickerController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 23/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension CapturesViewController {
	@objc func presentImagePickerController() {
		
		let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
		alert.addAction(UIAlertAction(title: "Open Camera", style: .default, handler: { _ in
			self.openCamera()
		}))
		
		alert.addAction(UIAlertAction(title: "Open Library", style: .default, handler: { _ in
			self.openLibrary()
		}))
		
		alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
		present(alert, animated: true, completion: nil)
	}
	
	func openCamera() {
		AVCaptureDevice.requestAccess(for: .video) { [weak self] permitted in
			if permitted {
				DispatchQueue.main.async {
					let imagePickerViewController = UIImagePickerController()
					imagePickerViewController.sourceType = .camera
					imagePickerViewController.allowsEditing = true
					imagePickerViewController.delegate = self
					self?.present(imagePickerViewController, animated: true, completion: nil)
				}
			} else {
				let alert = UIAlertController(title:  "Camera Not Available", message: "Camera access not permited", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
				DispatchQueue.main.async {
					self?.present(alert, animated: false, completion: nil)
				}
			}
		}
	}
	
	func openLibrary() {
		let imagePickerViewController = UIImagePickerController()
		imagePickerViewController.sourceType = .photoLibrary
		imagePickerViewController.allowsEditing = true
		imagePickerViewController.delegate = self
		self.present(imagePickerViewController, animated: true, completion: nil)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		picker.dismiss(animated: true, completion: {
			guard let image = info[.editedImage] as? UIImage else {
				print("No image found")
				return
			}
			self.day.media?.addTo(photos: image)
			self.galleryCollectionView.reloadData()
		})
	}
}
