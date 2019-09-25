//
//  FileManagerExtension.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 17/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation

enum DirectoryType: String {
    case photo = "Photos"
    case video = "Video"
    case voiceRecord = "VoiceRecords"
}

extension FileManager {
    func createDirectory (day: Day, directoryOf type: DirectoryType) -> String {
        
		let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "yyyy-MM-dd"
        let date = dateFormmater.string(from: day.date!)
			
		let mainPath = self.urls(for: .documentDirectory, in: .userDomainMask).first!
        let path = mainPath.appendingPathComponent(date).appendingPathComponent("/" + type.rawValue)
           try? self.createDirectory(atPath: path.path, withIntermediateDirectories: true, attributes: nil)
		return "\(date)/\(type.rawValue)"
       }
    
    func directoryExists(path: String) -> Bool {
        var directory: ObjCBool = ObjCBool(false)
        return fileExists(atPath: path, isDirectory: &directory)
    }

    func saveFileTo(path filepath: URL, withData data: Data) -> Bool {
        do {
            try data.write(to: filepath)
        } catch {
            print(error)
        }
        return fileExists(atPath: filepath.path)
    }
}
