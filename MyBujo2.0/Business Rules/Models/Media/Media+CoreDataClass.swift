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
	var mainPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
	
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
        photos?.append(image)
		
		save()
    }
	
	
	
    func addTo(photos images: [UIImage]) {
        photos?.append(contentsOf: images)
        save()
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
}
