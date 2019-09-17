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
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    var paths: [String] = []
    var day = CalendarManager.shared.selectedDay!
    
    let fm = FileManager.default
    let mainPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    var path = URL(fileURLWithPath: "/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        photosCollectionView.register(CaptureCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        if day.media?.photosPath == nil {
            day.media?.photosPath = createDayPhotosDirectory().path
            path = createDayPhotosDirectory()
            print(path)
        } else {
            path = URL(fileURLWithPath: day.media!.photosPath!)
            print(path)
            loadPhotos()
        }
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
        photosCollectionView.backgroundColor = .white
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
        if savePhoto(image: image) {
            loadPhotos()
        }
        photosCollectionView.reloadData()
    }
    
    func createDayPhotosDirectory() -> URL {
        let path = mainPath.appendingPathComponent(day.date!.description).appendingPathComponent("Photos")
        try? fm.createDirectory(atPath: path.path, withIntermediateDirectories: true, attributes: nil)
        return path
    }
    
    func savePhoto(image: UIImage) -> Bool {
        if let data = image.jpegData(compressionQuality: 1) {
            if day.media == nil {
                day.media = Media(context: CoreDataManager.context)
                day.media?.photosPath = createDayPhotosDirectory().path
                day.save()
            }
            
            let filenamePath = path.appendingPathComponent(image.hash.description)
            try? data.write(to: filenamePath)
            return fm.fileExists(atPath: filenamePath.path)
        }
        return false
    }
    
    func loadPhotos() {
        do {
            paths.removeAll()
            
            let contentsOfDocuments = try FileManager.default.contentsOfDirectory(atPath: day.media!.photosPath!)
            paths.append("notes")
            contentsOfDocuments.forEach { (item) in
                paths.append("\(day.media!.photosPath!)/\(item)")
            }
        } catch {
            print("nothing to show")
        }
    }
}

extension CapturesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paths.count == 0 ? 1 : paths.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CaptureCollectionViewCell else { return UICollectionViewCell()}
        switch indexPath.row {
        case 0:
            cell.setupCell(image: UIImage(named: "notes")!)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didPresentImagePickerController))
            cell.addGestureRecognizer(tapGesture)
            return cell
        default:
            guard let image = UIImage(contentsOfFile: paths[indexPath.row]) else { return UICollectionViewCell()}
            cell.setupCell(image: image)
            return cell
        }
        
    }
}

extension CapturesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
    }
}
