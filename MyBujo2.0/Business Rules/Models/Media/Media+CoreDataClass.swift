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
	
            return [UIImage]()
        }
    }()
    
    func addTo(photos image: UIImage) {
        photos?.append(image)
        //salvar no FileManager
    }
    func addTo(photos images: [UIImage]) {
        photos?.append(contentsOf: images)
        //salvar no FileManager
    }
    
    func save() {
        CoreDataManager.save()
    }
	
	private func getPhotosPaths() {
		self.photosPath
		try! FileManager.default.contentsOfDirectory(atPath: self.mainPath.appendingPathComponent(self.mainPath.appendPathComponent(self.photosPath!)))
	}
}
