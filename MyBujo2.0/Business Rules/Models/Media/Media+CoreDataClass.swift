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
		guard let images = getPhotosFrom(paths: paths) else { return nil }
		return images
    }
    
    func addTo(photos image: UIImage) {
//        if photos != nil {
//            photos!.append(image)
//        }
//        else {
//            photos = [UIImage]()
//            photos!.append(image)
//        }
		let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "yyyy-MM-dd"
		let date = dateFormmater.string(from: day!.date!)
		
		guard let photosPath = photosPath else { return }
		let path = mainPath.appendingPathComponent(photosPath).appendingPathComponent(date)
			
		guard let data = image.pngData() else {  return }
		
		_ = FileManager.default.saveFileTo(path: path , withData: data) 
		
	}
    
    func addTo(photos images: [UIImage]) {
        //salvar no FileManager
    }
    
    func save() {
        CoreDataManager.save()
    }
	
	private func getPhotosPaths() -> [String]? {
		do {
			let paths = try? FileManager.default.contentsOfDirectory(atPath: self.mainPath.appendingPathComponent(photosPath!).absoluteString)
			return paths
		} catch {
			print(error)
		}
		
	}

    private func getPhotosFrom(paths: [String]) -> [UIImage]? {
        let images: [UIImage] = paths.map { (path) -> UIImage in
			let image = UIImage(contentsOfFile: path)
            return image!
        }
        return images
    }
}
