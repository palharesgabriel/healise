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
	
	var photos: [UIImage]? {
        guard let paths = FileManager.default.getPaths(for: photosPath!) else { return nil }
		let sortedPaths = FileManager.default.sortPaths(paths: paths, mediaPath: photosPath!)
        guard let images: [UIImage] = FileManager.default.getMedia(from: sortedPaths, mediaPath: photosPath!) else { return nil }
		return images
    }
	
	func removePhoto(index: Int) -> Bool {
		guard let paths = FileManager.default.getPaths(for: photosPath!) else { return false }
		let sortedPaths = FileManager.default.sortPaths(paths: paths, mediaPath: photosPath!)
		do {
			let mainPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
			let pathToBeRemoved = mainPath.appendingPathComponent(photosPath!).appendingPathComponent(sortedPaths[index])
			try FileManager.default.removeItem(at: pathToBeRemoved)
			return true
		} catch {
			print(error)
			return false
		}
	}
    
    var audios: [Audio]? {
        guard let paths = FileManager.default.getPaths(for: voiceRecordsPath!) else { return nil }
        let sortedPaths = FileManager.default.sortPaths(paths: paths, mediaPath: voiceRecordsPath!)
        guard let audios: [Audio] = FileManager.default.getMedia(from: sortedPaths, mediaPath: voiceRecordsPath!) else { return nil }
        return audios
    }
    
    func addTo(photos image: UIImage) {
		guard let photosPath = photosPath else { return }
        FileManager.default.saveToFileManager(media: image, mediaPath: photosPath)
	}
    
    func save() {
        CoreDataManager.save()
    }
}
