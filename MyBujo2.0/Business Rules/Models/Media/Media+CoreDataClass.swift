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
    lazy var photos: [UIImage]? = {
        if let photos = self.photos {
            return photos
        } else {
            //AQUI TEM QUE PEGAR DO FILEMANAGER
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
}
