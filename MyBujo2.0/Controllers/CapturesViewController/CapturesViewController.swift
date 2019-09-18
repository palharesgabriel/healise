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
        flowLayout.minimumLineSpacing = 4
        flowLayout.minimumInteritemSpacing = 4
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    var paths: [String] = []
    var day = CalendarManager.shared.selectedDay!
    
    let fileManager = FileManager.default
    let mainPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    var path = URL(fileURLWithPath: "/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        photosCollectionView.register(CaptureCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        if day.media?.photosPath == nil {
            day.media?.photosPath = createDayPhotosDirectory()
        } else {
            path = mainPath.appendingPathComponent(day.media!.photosPath!)
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
            photosCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        view.backgroundColor = UIColor(named: "BlueBackground")
        photosCollectionView.backgroundColor = .white
    }
    
    @objc func didPresentImagePickerController() {
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.sourceType = .photoLibrary
        imagePickerViewController.allowsEditing = true
        imagePickerViewController.delegate = self
        self.present(imagePickerViewController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        if savePhoto(image: image) {
            loadPhotos()
        }
        
        photosCollectionView.reloadData()
    }
    
    func createDayPhotosDirectory() -> String {
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "yyyy-MM-dd"
        let date = dateFormmater.string(from: day.date!)
        
        let pathToSaveInCoreData = "\(date.description)/\("Photos")"
        
        let path = mainPath.appendingPathComponent(pathToSaveInCoreData)
        
        try? fileManager.createDirectory(atPath: path.path, withIntermediateDirectories: true, attributes: nil)
        
        return pathToSaveInCoreData
    }
    
    func savePhoto(image: UIImage) -> Bool {
        if let data = image.jpegData(compressionQuality: 1) {
            if day.media == nil {
                day.media = Media(context: CoreDataManager.context)
                day.media?.photosPath = createDayPhotosDirectory()
                day.save()
            }
            
            let filenamePath = mainPath.appendingPathComponent(day.media!.photosPath!).appendingPathComponent(image.hash.description)
            do {
                try data.write(to: filenamePath)
            } catch {
                print(error)
            }
            
            return fileManager.fileExists(atPath: filenamePath.path)
        }
        return false
    }
    
    func loadPhotos() {
        do {
            paths.removeAll()
            guard let media = day.media,
                let path = media.photosPath
                else { return }
            
            let contentsOfDocuments = try fileManager.contentsOfDirectory(atPath: mainPath.appendingPathComponent(path).path)
            
            paths.append("notes")
            contentsOfDocuments.forEach { (item) in
                paths.append("\(mainPath.appendingPathComponent(path).path)/\(item)")
            }
        } catch {
            print(error)
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
            cell.setupCell(image: UIImage(named: "addImage")!)
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
        return CGSize(width: 100, height: 100)
    }
}
