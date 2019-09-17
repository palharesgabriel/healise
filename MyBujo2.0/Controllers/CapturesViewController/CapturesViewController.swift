//
//  PhotosViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 10/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit
import Photos

class CapturesViewController: MediaViewController, ViewCode, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let photosCollectionView:UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func buildViewHierarchy() {
        view.addSubview(photosCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func setupAdditionalConfigurantion() {
        view.backgroundColor = UIColor(named: "BlueBackground")
    }
    
    @objc func didPresentImagePickerController() {
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.sourceType = .camera
        imagePickerViewController.allowsEditing = true
        imagePickerViewController.delegate = self
        self.present(imagePickerViewController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
    }
}

extension CapturesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) is CaptureCollectionViewCell else { return UICollectionViewCell()}
        
        return UICollectionViewCell()
    }
}

extension CapturesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
    }
}
