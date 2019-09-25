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
		flowLayout.minimumLineSpacing = 1
		flowLayout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.showsVerticalScrollIndicator = false
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
		photosCollectionView.register(NewPhotoCollectionViewCell.self, forCellWithReuseIdentifier: "NewPhotoCollectionViewCell")
        
		photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
		
		loadPhotos()
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
        photosCollectionView.backgroundColor = .white
    }
    
    func createDayPhotosDirectory() {
		
//		try? fileManager.createDirectory(atPath: path.path, withIntermediateDirectories: true, attributes: nil)
        
		let path = fileManager.createDirectory(day: day, directoryOf: .photo)
		
    }
    
    func savePhoto(image: UIImage) -> Bool {
        if let data = image.jpegData(compressionQuality: 1) {
	
            let filenamePath = mainPath.appendingPathComponent(day.media!.photosPath!).appendingPathComponent(image.hash.description)
            
            return fileManager.saveFileFrom(Path: filenamePath, WithData: data)
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
			sortPhotos()
        } catch {
            print(error)
        }
    }
	
	func getCreatedDateFromFile (path: String) -> Date? {
		do {
			let attr = try fileManager.attributesOfItem(atPath: path)
			return attr[FileAttributeKey.creationDate] as? Date
		} catch {
			return nil
		}
	
	}
	
	func sortPhotos () {
		paths.sort { (firstPath, secondPath) -> Bool in
			guard let firstDate = getCreatedDateFromFile(path: firstPath) else { return false }
			guard let secondDate = getCreatedDateFromFile(path: secondPath) else { return false }
			if firstDate > secondDate {
				return true
			}
			return false
		}
	}
}

extension CapturesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paths.count == 0 ? 1 : paths.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewPhotoCollectionViewCell", for: indexPath) as? NewPhotoCollectionViewCell else { return UICollectionViewCell()}

            return cell
        default:
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CaptureCollectionViewCell else { return UICollectionViewCell()}
            guard let image = UIImage(contentsOfFile: paths[indexPath.row]) else { return UICollectionViewCell()}
            cell.setupCell(image: image)
            return cell
        }
         
    }
}

extension CapturesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
			return CGSize(width: view.frame.width * 0.33, height: view.frame.width * 0.33)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            presentImagePickerController()
        default:
            let testController = FocusedPhotoViewController(with: [UIImage()])
            present(testController, animated: true, completion: nil)
        }
    }
}
