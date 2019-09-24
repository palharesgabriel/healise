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
            return getPhotosFromPaths(paths: getPhotosPaths())
        }
    }()
    
    func addTo(photos image: UIImage) {
        if photos != nil {
            photos!.append(image)
        }
        else{
            photos = [UIImage]()
            photos!.append(image)
        }
        
        //salvar no FileManager
    }
    func addTo(photos images: [UIImage]) {
        if photos != nil {
            photos!.append(contentsOf: images)
        }
        else{
            photos = [UIImage]()
            photos!.append(contentsOf: images)
        }
        
        //salvar no FileManager
    }
    
    func save() {
        CoreDataManager.save()
    }
	
	private func getPhotosPaths() -> [String]? {
        
        return try? FileManager.default.contentsOfDirectory(atPath: mainPath.appendingPathComponent(photosPath!).absoluteString)
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
