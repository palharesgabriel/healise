//
//  Media+CoreDataClass.swift
//  
//
//  Created by Adauto Pinheiro on 17/09/19.
//
//

import Foundation
import UIKit
import CoreData

@objc(Media)
public class Media: NSManagedObject {
	private var mainPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
	
    lazy var photos: [UIImage]? = {
        if let photos = self.photos {
            return photos
        } else {
			let paths = getPhotosPaths()
			let images = getPhotosImages(paths: paths!)
            return images
        }
    }()
    
    func addTo(photos image: UIImage) {
        if photos != nil {
            photos!.append(image)
        }
        else {
            photos = [UIImage]()
            photos!.append(image)
        }
        
        //salvar no FileManager
    }
    
    func addTo(photos images: [UIImage]) {
        if photos != nil {
            photos!.append(contentsOf: images)
        }
        else {
            photos = [UIImage]()
            photos!.append(contentsOf: images)
        }
        
        //salvar no FileManager
    }
    
    func save() {
        CoreDataManager.save()
    }
	
	private func getPhotosPaths() -> [String]? {
		do {
			let paths = try? FileManager.default.contentsOfDirectory(atPath: self.mainPath.appendingPathComponent(photosPath!).path)
			return paths
		} catch {
			print(error)
		}
		
	}
	
	private func getPhotosImages(paths: [String]) -> [UIImage] {
		var images:[UIImage] = []
		paths.forEach { path in
			images.append(UIImage(contentsOfFile: path)!)
		}
		return images
	}
    
    private func getPhotosFromPaths(paths: [String]?) -> [UIImage]? {
        guard let paths = paths else { return nil }
        let images: [UIImage] = paths.map { (path) -> UIImage in
            let image = UIImage(contentsOfFile: path)
            return image!
        }
        return images
    }
}
