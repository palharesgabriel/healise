//
//  Media.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 28/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import UIKit
class Media: NSObject{
    private var coreDataMedia: MediaCD
    var date: Date
    var photos: [UIImage]{
        didSet{
            guard let photo = photos.last else { return }
            guard let data = photo.pngData() else { return }
            saveItemInFileManager(data: data)
        }
    }
    
    override init() {
        self.coreDataMedia = MediaCD()
        self.photos = [UIImage]()
        self.date = Date()
        super.init()
    }
    
    init(coreDataMedia: MediaCD) {
        self.coreDataMedia = coreDataMedia
        self.photos = [UIImage]()
        self.date = Date()
        
    }
    
    func getItemsFromFileManager<T>(path: String, type: T){
        
    }
    
    func saveItemInFileManager(data: Data){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mmm DD yyyy"
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let path = documentsDirectory[0].appendingPathComponent(dateFormatter.string(from: date))
        
        //if directory exists create file
        let dataString = String(data: data, encoding: .utf8)
        FileManager.default.createFile(atPath: path.absoluteString + dataString!, contents: data)
        //else, create directory then create file
        
        do {
            try FileManager.default.createDirectory(atPath: path.absoluteString, withIntermediateDirectories: true, attributes: nil)
        }
        catch{
            print("Error creating directory: \(error.localizedDescription)")
        }
    }
}
