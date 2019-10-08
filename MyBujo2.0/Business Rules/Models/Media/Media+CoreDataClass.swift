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
