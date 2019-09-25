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
	
	var photos: [UIImage]? {
		guard let paths = getPhotosPaths() else { return nil }
		let sortedPaths = sortPaths(paths: paths)
		guard let images = getPhotosFrom(paths: sortedPaths) else { return nil }
		return images
    }
    
    func addTo(photos image: UIImage) {
		
		guard let photosPath = photosPath else { return }
		let path = mainPath.appendingPathComponent(photosPath).appendingPathComponent(image.hashValue.description)
			
		guard let data = image.pngData() else {  return }
		
		_ = FileManager.default.saveFileTo(path: path , withData: data)
		
	}
    
    func save() {
        CoreDataManager.save()
    }
	
	private func sortPaths (paths: [String]) -> [String] {
		var sortedPaths = paths
		sortedPaths.sort { (firstPath, secondPath) -> Bool in
			guard let firstDate = getCreatedDateFromFile(path: firstPath) else { return false }
			guard let secondDate = getCreatedDateFromFile(path: secondPath) else { return false }
			if firstDate > secondDate {
				return true
			}
			return false
		}
		return sortedPaths
	}
	
	private func getCreatedDateFromFile (path: String) -> Date? {
		do {
			let attr = try FileManager.default.attributesOfItem(atPath: path)
			return attr[FileAttributeKey.creationDate] as? Date
		} catch {
			return nil
		}
	}
	
	private func getPhotosPaths() -> [String]? {
		do {
			let paths = try FileManager.default.contentsOfDirectory(atPath: self.mainPath.appendingPathComponent(photosPath!).path)
			return paths
		} catch {
			print(error)
			return nil
		}
	}

    private func getPhotosFrom(paths: [String]) -> [UIImage]? {
        let images: [UIImage] = paths.map { (path) -> UIImage in
			let tempPath = self.mainPath.appendingPathComponent(photosPath!)
			let image = UIImage(contentsOfFile: tempPath.appendingPathComponent(path).path)
            return image!
        }
        return images
    }
}
